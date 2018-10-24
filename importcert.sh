#!/bin/bash

az keyvault certificate import --name mt-ssl-cert --vault-name oneweek-kv -f self.pfx --query id