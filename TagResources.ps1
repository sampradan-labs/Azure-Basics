#Azure version
az --version

#Login-AzureRmAccount

az login

az group create -l eastus -n RG1 --tags abc = 123

az storage account create -n mystorageaccount -g RG1-l eastus --sku Standard_LRS

az group show -n RG1--query tags

az resource list --tag app=testing

#Querying resources (Different ways)
az resource list --query []
az resource list --query [].[name,tags] --output table
#Return item at index 2
az resource list --query [1].[name,tags] --output table

#Return objects 0 thru 2
az resource list --query [0:2].name --output table

#Return objects matching a name cloudshellsample
az resource list --query " [?contains(name, 'cloudshell')]" --output table



#To be done using Cloud Shell on Azure
#Get tags for a resource

(Get-AzureRmResource -ResourceName "mystorageaccount34567" -ResourceGroupName "RG1").Tags

(Get-AzureRmResource -Tag @{app="testing"}).Name

Get-AzureRmResource -TagName app

#Get a reference to an Azure resource
$r = Get-AzureRmResource -ResourceName mystorageaccount34567 -ResourceGroupName RG1

#Retrieve existing resource tags, if any
$tags = (Get-AzureRmResource -ResourceName mystorageaccount34567 -ResourceGroupName RG1
).Tags

#Add new tags to exiting tags
$tags += @{Dept="IT"; LifeCyclePhase="Testing"}

#Write new tags to an Azure resource
Set-AzureRmResource -ResourceId $r.Id -Tag $tags -Force

#List tags and their number of occurences
Get-AzureRmTag

#Remove all tags
Set-AzureRmResource -Tag @{} -ResourceId $r.id -Force

#List tags and their number of occurences
Get-AzureRmTag

#Get all Resource Providers for a location
Get-AzResourceProvider -Location "eastus"