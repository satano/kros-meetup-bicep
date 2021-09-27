# Infrastructure as a code – Bicep

## Bicep príkazy

### Nasadenie do Azure

`az deployment group create --resource-group ba-meetup --template-file meetup.bicep`

`az deployment group create --resource-group ba-meetup --template-file meetup.bicep --parameters meetup.parameters.json --parameters prefix=LoremIpsumDolor --name test-01`

### Kontrola pred nasadením (what if)

`az deployment group what-if --resource-group ba-meetup --template-file meetup.bicep`

### Vymazanie všetkého v resource group

`az deployment group create --resource-group ba-meetup --template-file resource-group-cleanup.bicep --name delete-01 --mode Complete`

### Konverzia ARM šablóny do Bicep

`az bicep decompile --file arm-template.json`

### Konverzia Bicep do ARM šablóny

`az bicep build --file meetup.bicep`
