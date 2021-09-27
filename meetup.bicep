@description('Prefix for services to make their names unique.')
param prefix string

param appServicePlanSku object = {
  name: 'B1'
  tier: 'Basic'
  size: 'B1'
}

param aspnetEnvironment string = 'Test'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'meetup-asp'
  location:  resourceGroup().location
  sku: appServicePlanSku
}

module apiServices 'modules/api-services.bicep' = {
  name: '${deployment().name}-api-services'
  params: {
    prefix: prefix
    aspnetEnvironment: aspnetEnvironment
    appServicePlanId: appServicePlan.id
    services: [
      'Data'
      'Admin'
    ]
  }
}
