#!/bin/bash
# Download and execute setup script from GitHub
curl -fsSL ${setup_script_url} | bash -s -- "${db_name}" "${db_username}" "${db_password}" "${app_repo_url}"