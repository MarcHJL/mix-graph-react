import { Environment, Network, RecordSource, Store } from 'relay-runtime';
import fetchGraphQL from './fetchGraphQL';
  
const fetchRelay = async (params, variables) => {
  console.log(`fetching query ${params.name} with ${JSON.stringify(variables)}`);
  return fetchGraphQL(params.text, variables);
}
  
const RelayEnvironment = new Environment({
  network: Network.create(fetchRelay),
  store: new Store(new RecordSource()),
});
  
export default RelayEnvironment;