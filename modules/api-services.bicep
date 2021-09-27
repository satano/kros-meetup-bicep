param prefix string
param appServicePlanId string
param aspnetEnvironment string
param appInsightsInstrumentationKey string
param services array = []

resource apiServices 'Microsoft.Web/sites@2021-01-15' = [for service in services: {
  name: '${prefix}-${toLower(service)}-api'
  location:  resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    clientAffinityEnabled: false
    siteConfig: {
      netFrameworkVersion: 'v6.0'
      http20Enabled: true
      alwaysOn: true
      webSocketsEnabled: false
      ftpsState: 'Disabled'

      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: aspnetEnvironment
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsInstrumentationKey
        }
        {
          name: 'WEBSITE_ENABLE_SYNC_UPDATE_SITE'
          value: 'true'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
}]

output services array = [for i in range(0, length(services)): {
  'name': services[i]
  'host': 'https://${apiServices[i].properties.defaultHostName}'
  'identityId': apiServices[i].identity.principalId
}]
