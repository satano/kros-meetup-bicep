resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'ba-meetup-asp'
  location: resourceGroup().location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
  }
}

resource apiService 'Microsoft.Web/sites@2021-01-15' = {
  name: 'ba-meetup-example-1-api'
  location: resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
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
          value: 'Test'
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
}
