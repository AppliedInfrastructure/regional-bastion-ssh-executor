# Regional Bastion SSH Executor Plugin for Rundeck
A Rundeck NodeExecutor plugin supporting SSH commands via an optional bastion (jump) host.  A variety of bastion host configurations are supported:
* No bastion host (for direct SSH)
* Static/global bastion host (for single region, multi-region, etc.)
* Dynamic bastion host using a dynamic REGION variable (for multi-region, multi-cloud, etc.)

### Basic Usage
To enable dynamic bastion hostnames, nodes should include the name of a supported cloud region as a node tag.  In AWS, for example, this tag may be something like "us-west-1", "eu-central-1", or any other official AWS region name.  Other regions/providers will be added in the near future, as well as support for configuring arbitrary region names.

The region name may then be included in the configurable bastion hostname pattern as `${REGION}`:
* Given a node that includes the tag `eu-central-1`
* And a configured bastion hostname pattern of `${REGION}-bastion.example.net`
* The bastion hostname will expand to `eu-central-1-bastion.example.net`

### Installation
Download the release ZIP file and drop into your Rundeck plugins directory (see http://rundeck.org/docs/plugins-user-guide/installing.html - no restart necessary).

Once installed, use the plugin configuration panel to select the "Regional Bastion SSH" plugin as the Default Node Executor for your project.
