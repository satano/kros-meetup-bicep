@description('Prefix for services to make their names unique.')
param prefix string

param appServicePlanSku object = {
  name: 'B1'
  tier: 'Basic'
  size: 'B1'
}

param aspnetEnvironment string = 'Test'

resource appInsights 'microsoft.insights/components@2020-02-02' = {
  name: 'meetup-ain'
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    SamplingPercentage: 100
    DisableIpMasking: false
    IngestionMode: 'ApplicationInsights'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'meetup-asp'
  location:  resourceGroup().location
  sku: appServicePlanSku
}

module apiServices 'modules/api-services.bicep' = {
  name: 'api-services'
  params: {
    prefix: prefix
    aspnetEnvironment: aspnetEnvironment
    appInsightsInstrumentationKey: appInsights.properties.InstrumentationKey
    appServicePlanId: appServicePlan.id
    services: [
      'Data'
      'Admin'
    ]
  }
}

output appInsights object = {
  'instrumentationKey': appInsights.properties.InstrumentationKey
}

output apiServices array = apiServices.outputs.services
