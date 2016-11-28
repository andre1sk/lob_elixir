## Elixir Lob.com API cleint

Covered endpoints:
* [addresses](#addresses) - Lob.Resources.Addresses
* [bank_accounts](#bankaccounts) - Lob.Resources.BankAccounts
* [checks](#checks) - Lob.Resources.Checks
* [letters](#letters) - Lob.Resources.Letters
* [postcards](#postcards) - Lob.Resources.Postcards




##### API
You can follow docs at
https://lob.com/docs
The field names are identical to the names in the docs just convert them to atoms
```elixir
	alias Lob.Resources.Addresses

    address = %{
      name: "John Doe",
      address_line1: "1600 Amphitheatre Parkway",
      address_city: "Mountain View",
      address_state: "CA",
      address_zip: "94043",
      address_country: "US",
    }

    # CREATE
    {:ok, data} = Addresses.create(address, "YOUR_API_KEY")

    # RETRIEVE
    {:ok, data} = Addresses.retrieve("adr_id", "YOUR_API_KEY")

    # LIST
    {:ok, data} = Addresses.list(%{limit: 5}, "YOUR_API_KEY")
```

 All functions return tuples {:ok, data} or {:error, {[error_type](#error-types), error_data}}.


#### Addresses
module: Lob.Resources.Addresses
```elixir
Lob.Resources.Addresses.create(%{
  description: "string",
  name: "string max length 50",
  company: "string max length 50 you must set name company or both",
  address_line1: "string max length 200 required",
  address_line2: "string max length 200",
  address_country: "2 letter country code",
  address_city: "string max length 200 required for US",
  address_state: "string max length 40 required for US (2 letter code for US)",
  address_zip: "string max length 40 required for US",
  phone: "string max length 40",
  email: "string max length 100",
  metadata: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  }
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}


```elixir
Lob.Resources.Addresses.retrieve("adr_xxxxxxxx", "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}


```elixir
Lob.Resources.Addresses.delete("adr_xxxxxxxx", "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.Addresses.list(%{
  offset: 1, #integer
  limit: 1, #integer default 10 max 100
  include: true, # boolean  include the total count in response
  metadata: %{"string" => "string"}, # kv map to filter by metadata
  date_created: %{gt: "2016-11-19"} #map of date/date time filters (gt,lt,gte,lte)
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

#### BankAccounts

module: Lob.Resources.BankAccounts
```elixir
Lob.Resources.BankAccounts.create(%{
  description: "string",
  routing_number: "string 9 letters/numbers required",
  account_number: "string required",
  account_type: "string either: company or individual",
  signatory: "string required",
  metadata: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  }
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.BankAccounts.retrieve("bank_xxxxxxxx", "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.BankAccounts.verify("bank_xxxxxxxx", 3, 4, "YOUR_API_KEY") #id, integer deposit 1 in cents, integer deposit 1 in cents
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.BankAccounts.delete("bank_xxxxxxxx", "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.BankAccounts.list(%{
  offset: 1, #integer
  limit: 1, #integer default 10 max 100
  include: true, # boolean  include the total count in response
  metadata: %{"string" => "string"}, # kv map to filter by metadata
  date_created: %{gt: "2016-11-19"} #map of date/date time filters (gt,lt,gte,lte)
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}


#### Checks

module: Lob.Resources.Checks
```elixir
Lob.Resources.Checks.create(%{
  description: "string",
  to: "string address id or map with address required",
  from: "string address id or map with address required",
  bank_account: "string verified bank account id required",
  amount: 10.11, #float required
  memo: "string max length 40",
  check_number: 10, #integer
  logo: %{path: "/p/f.png", name: "logo"}, #map %{path: string, name: string} or %{url: string} or %{content: string_html}
  message: "string max length 400",
  check_bottom: %{path: "/p/f.pdf", name: "check_bottom"}, #map %{path: string, name: string} or %{url: string} or %{content: string_html}
  attachment: %{path: "/p/a.pdf", name: "attachment"}, #map %{path: string, name: string} or %{url: string} or %{content: string_html}
  data: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  },
  mail_type: "string either usps_first_class or ups_next_day_air",
  metadata: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  }
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.Checks.retrieve("chk_xxxxxxxx", "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.Checks.list(%{
  offset: 1, #integer
  limit: 1, #integer default 10 max 100
  include: true, # boolean  include the total count in response
  metadata: %{"string" => "string"}, # kv map to filter by metadata
  date_created: %{gt: "2016-11-19"} #map of date/date time filters (gt,lt,gte,lte)
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}


#### Letters

module: Lob.Resources.Letters
```elixir
Lob.Resources.Letters.create(%{
  description: "string",
  to: "string address id or map with address required",
  from: "string address id or map with address required",
  color: true, #boolean
  file: %{path: "/p/a.pdf", name: "file"}, #map %{path: string, name: string} or %{url: string} or %{content: string_html} required
  data: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  },
  double_sided: true, #boolean
  address_placement: "string either top_first_page or insert_blank_page",
  return_envelope: true, #boolean
  perforated_page: 1, #integer required if return_envelope is true
  extra_service: "string certified or registered",
  metadata: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  }
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.Letters.retrieve("ltr_xxxxxxxx", "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.Letters.list(%{
  offset: 1, #integer
  limit: 1, #integer default 10 max 100
  include: true, # boolean  include the total count in response
  metadata: %{"string" => "string"}, # kv map to filter by metadata
  date_created: %{gt: "2016-11-19"} #map of date/date time filters (gt,lt,gte,lte)
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}



#### Postcards

module: Lob.Resources.Postcards
```elixir
Lob.Resources.Postcards.create(%{
  description: "string",
  to: "string address id or map with address required",
  from: "string address id or map with address",
  front: %{path: "/p/a.pdf", name: "front"}, #map %{path: string, name: string} or %{url: string} or %{content: string_html} required
  back: %{path: "/p/a.pdf", name: "back"}, #map %{path: string, name: string} or %{url: string} or %{content: string_html}
  data: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  },
  message: "string max length 350",
  size: "string either 4x6 or 6x9 or 6x11",
  metadata: %{
    "map with string keys" => "and string values",
    "keys at most 40 characters " => "and value string at most 500"
  }
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.Postcards.retrieve("psc_xxxxxxxx", "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}

```elixir
Lob.Resources.Postcards.list(%{
  offset: 1, #integer
  limit: 1, #integer default 10 max 100
  include: true, # boolean  include the total count in response
  metadata: %{"string" => "string"}, # kv map to filter by metadata
  date_created: %{gt: "2016-11-19"} #map of date/date time filters (gt,lt,gte,lte)
}, "YOUR_API_KEY")
```
returns {:ok, data} or {:error, {[error_type](#error-types), error_data}}






#### Error Types
* :validation - failed local validation check
* :network - network error
* :app - application error
