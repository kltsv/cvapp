import subprocess
import re
import csv
import json
import logging
from datetime import datetime
from pathlib import Path
import requests
from requests.exceptions import RequestException

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[logging.StreamHandler()]
)
logger = logging.getLogger(__name__)

def run_dart_pub_deps():
    """Run 'dart pub deps --style=compact' and return its output."""
    logger.info("Executing 'dart pub deps --style=compact'...")
    try:
        result = subprocess.run(
            ['dart', 'pub', 'deps', '--style=compact'],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        logger.error(f"Command failed: {e.stderr}")
        raise
    except Exception as e:
        logger.error(f"Unexpected error: {str(e)}")
        raise

def parse_dependencies(output):
    """Parse dependencies from dart pub deps output."""
    logger.info("Parsing dependencies...")
    deps = {}
    current_section = None
    dep_pattern = re.compile(r'^- (\S+)\s+(\S+)(?:\s+\[.*\])?$')

    for line in output.splitlines():
        line = line.strip()
        if not line:
            continue
        if line.endswith('dependencies:'):
            current_section = 'dependencies'
        elif line.endswith('dev dependencies:'):
            current_section = 'dev_dependencies'
        elif line.endswith('transitive dependencies:'):
            current_section = 'transitive_dependencies'
        elif current_section and line.startswith('- '):
            match = dep_pattern.match(line)
            if match:
                dep_name, dep_version = match.groups()
                deps[dep_name] = dep_version
                logger.debug(f"Found dependency: {dep_name}@{dep_version}")

    logger.info(f"Found {len(deps)} unique dependencies")
    return deps

def get_package_info(dep_name):
    """Fetch package info from pub.dev API."""
    url = f"https://pub.dev/api/packages/{dep_name}"
    logger.info(f"Fetching info for {dep_name}...")
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.json()
    except RequestException as e:
        logger.error(f"Failed to fetch {dep_name}: {str(e)}")
        return None

def process_dependency(dep_name, dep_version):
    """Process single dependency and return analyzed data."""
    data = {
        'dep_name': dep_name,
        'dep_local_version': dep_version,
        'dep_latest_version': None,
        'outdated': None,
        'latest_version_published': None
    }

    package_info = get_package_info(dep_name)
    if not package_info:
        return None

    latest_version = package_info.get('latest', {}).get('version')
    if not latest_version:
        return None

    data['dep_latest_version'] = latest_version
    latest_published = package_info['latest'].get('published')
    
    # Find local version publish date
    local_published = None
    for version in package_info.get('versions', []):
        if version['version'] == dep_version:
            local_published = version.get('published')
            break

    if latest_published and local_published:
        try:
            latest_date = datetime.fromisoformat(latest_published.replace('Z', '+00:00'))
            local_date = datetime.fromisoformat(local_published.replace('Z', '+00:00'))
            data['latest_version_published'] = latest_date.strftime('%Y.%m.%d')
            data['outdated'] = (latest_date - local_date).days
        except Exception as e:
            logger.error(f"Date parsing error for {dep_name}: {str(e)}")

    return data

def write_to_csv(data, filename):
    """Write data to CSV file."""
    output_dir = Path('build/output')
    output_dir.mkdir(parents=True, exist_ok=True)
    
    with open(filename, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)
    logger.info(f"Report saved to {filename}")

def write_raw_deps_output(output, filename):
    """Write the raw output of 'dart pub deps' to a text file."""
    output_dir = Path('build/output')
    output_dir.mkdir(parents=True, exist_ok=True)
    
    file_path = output_dir / filename
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(output)
    logger.info(f"Raw dependencies output saved to {file_path}")

def main():
    try:
        # Step 1: Get dependencies
        deps_output = run_dart_pub_deps()
        
        # Step 2: Save raw dependencies output to a file
        write_raw_deps_output(deps_output, 'deps.txt')

        # Step 3: Parse dependencies
        dependencies = parse_dependencies(deps_output)
        
        results = []
        # Steps 4-5: Process each dependency
        for dep_name, dep_version in dependencies.items():
            processed = process_dependency(dep_name, dep_version)
            if processed:
                results.append(processed)
                logger.info(f"Processed {dep_name}")
            else:
                logger.warning(f"Skipped {dep_name} due to errors")
        
        # Step 6: Save results
        write_to_csv(results, 'build/output/deps_status.csv')
        
    except Exception as e:
        logger.error(f"Script failed: {str(e)}")
        raise

if __name__ == "__main__":
    main()
