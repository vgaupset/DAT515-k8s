using 'main.bicep'

param adminPasswordOrKey = readEnvironmentVariable('PUBLIC_KEY','')
param adminUsername = 'vogadm'
param vmName = 'dat515-ubuntu'
param virtualNetworkName = 'dat515-vnet'
param subnetName = 'dat515-subnet'

