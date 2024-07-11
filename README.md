# Dev Server
The purpose of the dev server scripts and infrastructure template are to enable you to do remote development work on an AWS VM without direct interaction with AWS CLI or console.

You'll need to have the AWS CLI installed and configured for these scripts to work.

State for the dev server will live in the state folder. You shouldn't need to mess with that.

## Deploy
The deploy script will deploy a cloudformation stack containing an EC2 VM and the associated objects needed for SSH access and development. The repo will be pre-cloned on your dev server.

Deployment is done in us-west-1 so please make sure to use a keypair from that region.

Simple Example
```
./scripts/deploy_dev_server.sh -k <path_to_key_pair>
./scripts/deploy_dev_server.sh -k <path_to_key_pair> -i t3a.2xlarge
```

GPU server model
```
./scripts/deploy_dev_server.sh -k <path_to_key_pair> -i "g4dn.xlarge"
```

## Use
The use script serves 2 purposes:
1 - Restart the dev server if it's been hibernated
2 - Capture the dev server state and use that state to create configuration that will allow you to use remote SSH to connect VSCode to your dev server.
```
./scripts/use_dev_server.sh
```

## Hibernate
The hibernate script shuts down your dev server to save on cost while not in use.
```
./scripts/hibernate_dev_server.sh
```

## Teardown
The teardown script will delete the stack and all associated infrastructure. Be careful because you could nuke code changes which haven't been pushed to the repo.
```
./scripts/teardown_dev_server.sh
```