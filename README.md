# Ubuntu 20.04 CIS Validation scripts
## Running the scripts
Run the validation tests by cloning the repo and running the v
alidate-cis-hardening script
```
git clone https://github.com/odixer/Hardened-Ubuntu-20.04-LTS.git && sudo bash Hardened-Ubuntu-20.04-LTS/v
alidate-cis-hardening
```

The validation script uses bats (Bash Automated Testing System) to perform the validation tests. If bats isn't already installed it will be installed by the script via apt.

For the git clone and bats installation outbound connections to ports 80,443,53 are required. You can enabled in UFW with the following commands:
```bash
ufw allow out to any port 80
ufw allow out to any port 443
ufw allow out to any port 53
```
You can close these ports after the installation by running:
```bash
ufw delete allow out 80
ufw delete allow out 443
ufw delete allow out 53
```
