param (
    $templateFile = 'src/infra/main.bicep',
    $templateParameterFile = 'src/infra/main.bicepparam',
    $deploymentStackName = 'deploymentstack',
    $resourceGroupName = 'dat515'
)

New-AzResourceGroupDeploymentStack  -TemplateFile $templateFile `
                                    -TemplateParameterFile $templateParameterFile `
                                    -Name $deploymentStackName `
                                    -ResourceGroupName $resourceGroupName