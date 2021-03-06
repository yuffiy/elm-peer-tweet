import { dht } from './Common';

const decodeHashesArray = (value) =>
  value.toString() ? value.toString().match(/.{1,40}/g) : [];

const decodeKey = (key, value) => {
  switch (key) {
    case 't': return { [key]: value.toString() };
    case 'n': return { [key]: value.toString() };
    case 'a': return { [key]: value.toString() };
    case 'd': return { [key]: value.readIntBE(0, value.length) };
    case 'l': return { [key]: decodeHashesArray(value) };
    case 'f': return { [key]: decodeHashesArray(value) };
    case 'next': return { [key]: decodeHashesArray(value) };
    default: return {};
  }
};

const decodeKeys = (values) =>
  Object.keys(values)
    .reduce((accumulated, key) => (
      { ...accumulated, ...decodeKey(key, values[key]) }
    ), {});

const addNext = (values) =>
  ({...values, next: (values.next || new Buffer([])) });

const decodeItem = (hash, item) =>
  ({ hash: hash, ...decodeKeys(addNext(item.v)) });

export const download = (hash, callback) => {
  console.warn('Downloading', hash);

  dht.get(hash, (err, item) => {
    if (err === null && item === null) err = 'Not Found';
    err ? console.error('Download', hash, err) : console.info('Downloaded', hash, item && decodeItem(hash, item));

    callback(err, item && decodeItem(hash, item));
  });
};

export default { download };
