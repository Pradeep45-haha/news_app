//every news from the last five years
//endpoint -> v2/everything
//the everything endpoint does not support any query parameter except the q word and also date parameter
//top headlined for country category and publishers
//endpoint -> /v2/top-headlines
//match words in title description and content of news
//q=textToMatch
//pageSize=20
//page=2
//? for starting query and & for using search parameters and = for parameter value
//if any search parameter is null remove it from api url
//append multiple search parameter using &

Map<String, String> countryNameCodeMap = {
  "Argentina": "ar",
  "Australia": "au",
  "Austria": "at",
  "Belgium": "be",
  "Brazil": "br",
  "Bulgaria": "bg",
  "Canada": "ca",
  "China": "cn",
  "Colombia": "co",
  "Cuba": "cu",
  "Czech Republic": "cz",
  "Egypt": "eg",
  "France": "fr",
  "Germany": "de",
  "Greece": "gr",
  "Hong Kong": "hk",
  "Hungary": "hu",
  "India": "in",
  "Indonesia": "id",
  "Ireland": "ie",
  "Israel": "il",
  "Italy": "it",
  "Japan": "jp",
  "Latvia": "lv",
  "Lithuania": "lt",
  "Malaysia": "my",
  "Mexico": "mx",
  "Morocco": "ma",
  "Netherlands": "nl",
  "New Zealand": "nz",
  "Nigeria": "ng",
  "Norway": "no",
  "Philippines": "ph",
  "Poland": "pl",
  "Portugal": "pt",
  "Romania": "ro",
  "Russia": "ru",
  "Saudi Arabia": "sa",
  "Serbia": "rs",
  "Singapore": "sg",
  "Slovakia": "sk",
  "Slovenia": "si",
  "South Africa": "za",
  "South Korea": "kr",
  "Sweden": "se",
  "Switzerland": "ch",
  "Taiwan": "tw",
  "Thailand": "th",
  "Turkey": "tr",
  "UAE": "ae",
  "Ukraine": "ua",
  "United Kingdom": "gb",
  "United States": "us",
  "Venuzuela": "ve"
};
