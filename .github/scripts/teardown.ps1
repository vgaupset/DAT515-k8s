param (
    $deploymentStackName = 'deploymentstack',
    $resourceGroupName = 'dat515'
)

Remove-AzResourceGroupDeploymentStack   -Name $deploymentStackName `
                                        -ResourceGroupName $resourceGroupName `
                                        -DeleteResources