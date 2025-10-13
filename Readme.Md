Bitwarden:

1. Go to > https://github.com/bitwarden/sdk-sm/releases/tag/bws-v1.0.0; Download appropriate "bws"
2. Go to BW console > Secrete manager > Machine account > Click on account id > Access Token > Create > Copy
3. CLI > export BWS_ACCESS_TOKEN="Token"
4. Go to BW console > Secrete manager > Machine account > config > copy organisation id
5. Provide organisation Id and Project name on terraform.tfvars like terraform.tfvars.example
