# Codewars

A simple [Codewars](https://www.codewars.com) API wrapper written in Elixir.
API docs can be found at: https://dev.codewars.com

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `codewars` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:codewars, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/codewars_client](https://hexdocs.pm/codewars).

## Examples

### Initialize client

All the functions in provided library require the `client` argument.
Client can be instantiated with an API token. Token can be found at: https://www.codewars.com/users/edit.

```elixir
client = Codewars.Client.new(token)
```

However all available endpoints at the moment don't require authentication, so
this will work as well:
```elixir
client = Codewars.Client.new
```

### Get completed katas
```elixir
iex(7)> Codewars.CodeChallenges.completed(client, "Bajena")
{200,
 %{
   data: [
     %{
       completedAt: "2019-10-14T20:08:08.701Z",
       completedLanguages: ["elixir"],
       id: "530e15517bc88ac656000716",
       name: "Rot13",
       slug: "rot13-1"
     },
     ...
   ],
   totalItems: 19,
   totalPages: 1
 },
 %HTTPoison.Response{
   body: %{
     data: [
       %{
         completedAt: "2019-10-14T20:08:08.701Z",
         completedLanguages: ["elixir"],
         id: "530e15517bc88ac656000716",
         name: "Rot13",
         slug: "rot13-1"
       },
       ...
     ],
     totalItems: 19,
     totalPages: 1
   },
   headers: [
     {"Date", "Sun, 20 Oct 2019 18:02:00 GMT"},
     {"Content-Type", "application/json; charset=utf-8"},
     {"Transfer-Encoding", "chunked"},
     {"Connection", "keep-alive"},
     {"Set-Cookie",
      "__cfduid=d951b9b0f84fe8ad235f43528d94fe3ef1571594520; expires=Mon, 19-Oct-20 18:02:00 GMT; path=/; domain=.codewars.com; HttpOnly; Secure"},
     {"X-Frame-Options", "SAMEORIGIN"},
     {"X-XSS-Protection", "1; mode=block"},
     {"X-Content-Type-Options", "nosniff"},
     {"ETag", "W/\"7d5105cca92c85f5fb77d30c71127175\""},
     {"Cache-Control", "max-age=0, private, must-revalidate"},
     {"X-Request-Id", "5038e05f-1d76-45e3-b55f-e04e66d7fccf"},
     {"X-Runtime", "0.015894"},
     {"X-Rack-Cache", "miss"},
     {"Via", "1.1 google"},
     {"Alt-Svc", "clear"},
     {"CF-Cache-Status", "DYNAMIC"},
     {"Expect-CT",
      "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
     {"Server", "cloudflare"},
     {"CF-RAY", "528ce678292c40e6-HAM"}
   ],
   request: %HTTPoison.Request{
     body: "",
     headers: [],
     method: :get,
     options: [],
     params: %{},
     url: "https://www.codewars.com/api/v1/users/Bajena/code-challenges/completed?page=0"
   },
   request_url: "https://www.codewars.com/api/v1/users/Bajena/code-challenges/completed?page=0",
   status_code: 200
 }}
 ```

 This endpoint is paginated (0-based). Next pages can be queried by adding third argument:
```elixir
iex(8)> Codewars.CodeChallenges.completed(client, "Bajena", 2)
{200, %{data: [], totalItems: 19, totalPages: 1},
 %HTTPoison.Response{
   body: %{data: [], totalItems: 19, totalPages: 1},
   headers: [
     {"Date", "Sun, 20 Oct 2019 18:03:04 GMT"},
     {"Content-Type", "application/json; charset=utf-8"},
     {"Transfer-Encoding", "chunked"},
     {"Connection", "keep-alive"},
     {"Set-Cookie",
      "__cfduid=d48a43f9807eadf5e551125ce3ad4753d1571594584; expires=Mon, 19-Oct-20 18:03:04 GMT; path=/; domain=.codewars.com; HttpOnly; Secure"},
     {"X-Frame-Options", "SAMEORIGIN"},
     {"X-XSS-Protection", "1; mode=block"},
     {"X-Content-Type-Options", "nosniff"},
     {"ETag", "W/\"7401ce174b234d05c38d28b554e4123b\""},
     {"Cache-Control", "max-age=0, private, must-revalidate"},
     {"X-Request-Id", "5996f4da-35d2-417a-bdfb-b17eb70be2fc"},
     {"X-Runtime", "0.013390"},
     {"X-Rack-Cache", "miss"},
     {"Via", "1.1 google"},
     {"Alt-Svc", "clear"},
     {"CF-Cache-Status", "DYNAMIC"},
     {"Expect-CT",
      "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
     {"Server", "cloudflare"},
     {"CF-RAY", "528ce808de2c40e6-HAM"}
   ],
   request: %HTTPoison.Request{
     body: "",
     headers: [],
     method: :get,
     options: [],
     params: %{},
     url: "https://www.codewars.com/api/v1/users/Bajena/code-challenges/completed?page=2"
   },
   request_url: "https://www.codewars.com/api/v1/users/Bajena/code-challenges/completed?page=2",
   status_code: 200
 }}
 ```

 ### Get authored challenges
 ```elixir
 Codewars.CodeChallenges.authored(client, "g964")
{200,
 %{
   data: [
     %{
       description: "Given an array of positive or negative integers \n\n<code> I= [i<sub>1</sub>,..,i<sub>n</sub>]</code>\n\nyou have to produce a sorted array P of the form \n\n<code>[ [p, sum of all i<sub>j</sub> of I for which p is a prime factor (p positive) of i<sub>j</sub>] ...]</code>\n\nP will be sorted by increasing order of the prime numbers.\nThe final result has to be given as a string in Java, C#, C, C++ and as an array of arrays in other languages.\n\nExample:\n\n```fortran\nI = (/12, 15/); // result = \"(2 12)(3 27)(5 15)\"\n```\n```python\nI = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]\n```\n```elixir\nI = [12, 15] # result = [{2, 12}, {3, 27}, {5, 15}]\n```\n```rust\nI = [12, 15] # result = [(2, 12), (3, 27), (5, 15)]\n```\n```swift\nI = [12, 15] # result = [(2, 12), (3, 27), (5, 15)]\n```\n```ruby\nI = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]\n```\n```java\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```cpp\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```c\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```csharp\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```clojure\nI = [12, 15] ; result = [[2, 12], [3, 27], [5, 15]]\n```\n```haskell\nI = [12, 15] -- result = [(2,12),(3,27),(5,15)]\n```\n```javascript\nI = [12, 15]; //result = [[2, 12], [3, 27], [5, 15]]\n```\n```coffeescript\nI = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]\n```\n```typescript\nI = [12, 15]; //result = [[2, 12], [3, 27], [5, 15]]\n```\n```php\nI = [12, 15]; //result = [[2, 12], [3, 27], [5, 15]]\n```\n\n[2, 3, 5] is the list of all prime factors of the elements of I, hence the result.\n\n**Notes:**\n- It can happen that a sum is 0 if some numbers are negative!\n\nExample: I = [15, 30, -45]\n5 divides 15, 30 and (-45) so 5 appears in the result, the sum of the numbers for which 5 is a factor is 0 so we have [5, 0] in the result amongst others. \n\n- In Fortran - as in any other language - the returned string is not permitted to contain any redundant trailing whitespace: you can use dynamically allocated character strings.\n\n\n",
       id: "54d496788776e49e6b00052f",
       languages: ["java", "python", "csharp", "ruby", "clojure", "haskell",
        "javascript", "coffeescript", "cpp", "typescript", "elixir", "php",
        "crystal", "c", "rust", "swift", "fsharp", "r", "shell", "ocaml",
        "kotlin", "fortran", "groovy", "julia", "scala", "powershell", "go",
        "nim", "reason", "racket", "vb"],
       name: "Sum by Factors",
       rank: -4,
       rankName: "4 kyu",
       tags: ["Algorithms", "Numbers", "Data Types", "Arrays"]
     },
     ...
   ]
 },
 %HTTPoison.Response{
   body: %{
     data: [
       %{
         description: "Given an array of positive or negative integers \n\n<code> I= [i<sub>1</sub>,..,i<sub>n</sub>]</code>\n\nyou have to produce a sorted array P of the form \n\n<code>[ [p, sum of all i<sub>j</sub> of I for which p is a prime factor (p positive) of i<sub>j</sub>] ...]</code>\n\nP will be sorted by increasing order of the prime numbers.\nThe final result has to be given as a string in Java, C#, C, C++ and as an array of arrays in other languages.\n\nExample:\n\n```fortran\nI = (/12, 15/); // result = \"(2 12)(3 27)(5 15)\"\n```\n```python\nI = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]\n```\n```elixir\nI = [12, 15] # result = [{2, 12}, {3, 27}, {5, 15}]\n```\n```rust\nI = [12, 15] # result = [(2, 12), (3, 27), (5, 15)]\n```\n```swift\nI = [12, 15] # result = [(2, 12), (3, 27), (5, 15)]\n```\n```ruby\nI = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]\n```\n```java\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```cpp\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```c\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```csharp\nI = {12, 15}; // result = \"(2 12)(3 27)(5 15)\"\n```\n```clojure\nI = [12, 15] ; result = [[2, 12], [3, 27], [5, 15]]\n```\n```haskell\nI = [12, 15] -- result = [(2,12),(3,27),(5,15)]\n```\n```javascript\nI = [12, 15]; //result = [[2, 12], [3, 27], [5, 15]]\n```\n```coffeescript\nI = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]\n```\n```typescript\nI = [12, 15]; //result = [[2, 12], [3, 27], [5, 15]]\n```\n```php\nI = [12, 15]; //result = [[2, 12], [3, 27], [5, 15]]\n```\n\n[2, 3, 5] is the list of all prime factors of the elements of I, hence the result.\n\n**Notes:**\n- It can happen that a sum is 0 if some numbers are negative!\n\nExample: I = [15, 30, -45]\n5 divides 15, 30 and (-45) so 5 appears in the result, the sum of the numbers for which 5 is a factor is 0 so we have [5, 0] in the result amongst others. \n\n- In Fortran - as in any other language - the returned string is not permitted to contain any redundant trailing whitespace: you can use dynamically allocated character strings.\n\n\n",
         id: "54d496788776e49e6b00052f",
         languages: ["java", "python", "csharp", "ruby", "clojure", "haskell",
          "javascript", "coffeescript", "cpp", "typescript", "elixir", "php",
          "crystal", "c", "rust", "swift", "fsharp", "r", "shell", "ocaml",
          "kotlin", "fortran", "groovy", "julia", "scala", "powershell", "go",
          "nim", "reason", "racket", "vb"],
         name: "Sum by Factors",
         rank: -4,
         rankName: "4 kyu",
         tags: ["Algorithms", "Numbers", "Data Types", "Arrays"]
       },
       ...
     ]
   },
   headers: [
     {"Date", "Sun, 20 Oct 2019 18:03:58 GMT"},
     {"Content-Type", "application/json; charset=utf-8"},
     {"Transfer-Encoding", "chunked"},
     {"Connection", "keep-alive"},
     {"Set-Cookie",
      "__cfduid=d8ef756ca533754c8f1092e49321e02091571594637; expires=Mon, 19-Oct-20 18:03:57 GMT; path=/; domain=.codewars.com; HttpOnly; Secure"},
     {"X-Frame-Options", "SAMEORIGIN"},
     {"X-XSS-Protection", "1; mode=block"},
     {"X-Content-Type-Options", "nosniff"},
     {"ETag", "W/\"62eb422ee9eca3b6bb9e0c0e50f4a783\""},
     {"Cache-Control", "max-age=0, private, must-revalidate"},
     {"X-Request-Id", "6723b866-1de0-4972-9b81-d51e9877b31b"},
     {"X-Runtime", "0.588289"},
     {"X-Rack-Cache", "miss"},
     {"Via", "1.1 google"},
     {"Alt-Svc", "clear"},
     {"CF-Cache-Status", "DYNAMIC"},
     {"Expect-CT",
      "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
     {"Server", "cloudflare"},
     {"CF-RAY", "528ce9566f5140e6-HAM"}
   ],
   request: %HTTPoison.Request{
     body: "",
     headers: [],
     method: :get,
     options: [],
     params: %{},
     url: "https://www.codewars.com/api/v1/users/g964/code-challenges/authored"
   },
   request_url: "https://www.codewars.com/api/v1/users/g964/code-challenges/authored",
   status_code: 200
 }}
 ```

 ### Find specific challenge (by slug or id)

```elixir
iex(15)> Codewars.CodeChallenges.find(client, "55b3425df71c1201a800009c")
{200,
 %{
   approvedAt: "2015-11-06T23:59:39.883Z",
   approvedBy: %{
     url: "https://www.codewars.com/users/joh_pot",
     username: "joh_pot"
   },
   category: "reference",
   contributorsWanted: true,
   createdAt: "2015-07-25T08:01:34.207Z",
   createdBy: %{url: "https://www.codewars.com/users/g964", username: "g964"},
   description: "You are the \"computer expert\" of a local Athletic Association (C.A.A.).\nMany teams of runners come to compete. Each time you get a string of \nall race results of every team who has run.\nFor example here is a string showing the individual results of a team of 5 runners:\n\n` \"01|15|59, 1|47|6, 01|17|20, 1|32|34, 2|3|17\" `\n\nEach part of the string is of the form: ` h|m|s `\nwhere h, m, s (h for hour, m for minutes, s for seconds) are positive or null integer (represented as strings) with one or two digits.\nThere are no traps in this format.\n\nTo compare the results of the teams you are asked for giving\nthree statistics; **range, average and median**.\n\n`Range` : difference between the lowest and highest values. \nIn {4, 6, 9, 3, 7} the lowest value is 3, and the highest is 9, \nso the range is 9 − 3 = 6.\n\n`Mean or Average` : To calculate mean, add together all of the numbers \nin a set and then divide the sum by the total count of numbers.\n\n`Median` : In statistics, the median is the number separating the higher half \nof a data sample from the lower half. \nThe median of a finite list of numbers can be found by arranging all \nthe observations from lowest value to highest value and picking the middle one \n(e.g., the median of {3, 3, 5, 9, 11} is 5) when there is an odd number of observations. \nIf there is an even number of observations, then there is no single middle value; \nthe median is then defined to be the mean of the two middle values\n(the median of {3, 5, 6, 9} is (5 + 6) / 2 = 5.5).\n\nYour task is to return a string giving these 3 values.  For the example given above,\nthe string result will be\n\n`\"Range: 00|47|18 Average: 01|35|15 Median: 01|32|34\"`\n\nof the form:\n\n`\"Range: hh|mm|ss Average: hh|mm|ss Median: hh|mm|ss\"`\n\nwhere hh, mm, ss are integers (represented by strings) with *each 2 digits*.\n\n*Remarks*: \n\n1. if a result in seconds is ab.xy... it will be given **truncated** as ab.\n\n2. if the given string is \"\" you will return \"\"\n",
   id: "55b3425df71c1201a800009c",
   languages: ["ruby", "python", "javascript", "haskell", "java", "csharp",
    "clojure", "coffeescript", "cpp", "php", "c", "swift", "crystal",
    "typescript", "r", "shell", "ocaml", "elixir", "fsharp", "julia", "scala",
    "powershell", "go", "nim", "rust", "reason", "racket"],
   name: "Statistics for an Athletic Association",
   publishedAt: "2015-07-25T08:08:11.653Z",
   rank: %{color: "yellow", id: -6, name: "6 kyu"},
   slug: "statistics-for-an-athletic-association",
   tags: ["Fundamentals", "Strings", "Data Types"],
   totalAttempts: 46639,
   totalCompleted: 3078,
   totalStars: 347,
   unresolved: %{issues: 0, suggestions: 0},
   url: "https://www.codewars.com/kata/statistics-for-an-athletic-association",
   voteScore: 480
 },
 %HTTPoison.Response{
   body: %{
     approvedAt: "2015-11-06T23:59:39.883Z",
     approvedBy: %{
       url: "https://www.codewars.com/users/joh_pot",
       username: "joh_pot"
     },
     category: "reference",
     contributorsWanted: true,
     createdAt: "2015-07-25T08:01:34.207Z",
     createdBy: %{url: "https://www.codewars.com/users/g964", username: "g964"},
     description: "You are the \"computer expert\" of a local Athletic Association (C.A.A.).\nMany teams of runners come to compete. Each time you get a string of \nall race results of every team who has run.\nFor example here is a string showing the individual results of a team of 5 runners:\n\n` \"01|15|59, 1|47|6, 01|17|20, 1|32|34, 2|3|17\" `\n\nEach part of the string is of the form: ` h|m|s `\nwhere h, m, s (h for hour, m for minutes, s for seconds) are positive or null integer (represented as strings) with one or two digits.\nThere are no traps in this format.\n\nTo compare the results of the teams you are asked for giving\nthree statistics; **range, average and median**.\n\n`Range` : difference between the lowest and highest values. \nIn {4, 6, 9, 3, 7} the lowest value is 3, and the highest is 9, \nso the range is 9 − 3 = 6.\n\n`Mean or Average` : To calculate mean, add together all of the numbers \nin a set and then divide the sum by the total count of numbers.\n\n`Median` : In statistics, the median is the number separating the higher half \nof a data sample from the lower half. \nThe median of a finite list of numbers can be found by arranging all \nthe observations from lowest value to highest value and picking the middle one \n(e.g., the median of {3, 3, 5, 9, 11} is 5) when there is an odd number of observations. \nIf there is an even number of observations, then there is no single middle value; \nthe median is then defined to be the mean of the two middle values\n(the median of {3, 5, 6, 9} is (5 + 6) / 2 = 5.5).\n\nYour task is to return a string giving these 3 values.  For the example given above,\nthe string result will be\n\n`\"Range: 00|47|18 Average: 01|35|15 Median: 01|32|34\"`\n\nof the form:\n\n`\"Range: hh|mm|ss Average: hh|mm|ss Median: hh|mm|ss\"`\n\nwhere hh, mm, ss are integers (represented by strings) with *each 2 digits*.\n\n*Remarks*: \n\n1. if a result in seconds is ab.xy... it will be given **truncated** as ab.\n\n2. if the given string is \"\" you will return \"\"\n",
     id: "55b3425df71c1201a800009c",
     languages: ["ruby", "python", "javascript", "haskell", "java", "csharp",
      "clojure", "coffeescript", "cpp", "php", "c", "swift", "crystal",
      "typescript", "r", "shell", "ocaml", "elixir", "fsharp", "julia", "scala",
      "powershell", "go", "nim", "rust", "reason", "racket"],
     name: "Statistics for an Athletic Association",
     publishedAt: "2015-07-25T08:08:11.653Z",
     rank: %{color: "yellow", id: -6, name: "6 kyu"},
     slug: "statistics-for-an-athletic-association",
     tags: ["Fundamentals", "Strings", "Data Types"],
     totalAttempts: 46639,
     totalCompleted: 3078,
     totalStars: 347,
     unresolved: %{issues: 0, suggestions: 0},
     url: "https://www.codewars.com/kata/statistics-for-an-athletic-association",
     voteScore: 480
   },
   headers: [
     {"Date", "Sun, 20 Oct 2019 18:08:19 GMT"},
     {"Content-Type", "application/json; charset=utf-8"},
     {"Transfer-Encoding", "chunked"},
     {"Connection", "keep-alive"},
     {"Set-Cookie",
      "__cfduid=d1c2ee0f40ad1a7493dc25b189625a5d41571594899; expires=Mon, 19-Oct-20 18:08:19 GMT; path=/; domain=.codewars.com; HttpOnly; Secure"},
     {"X-Frame-Options", "SAMEORIGIN"},
     {"X-XSS-Protection", "1; mode=block"},
     {"X-Content-Type-Options", "nosniff"},
     {"ETag", "W/\"16ae16cf5ca6ef87acba357a9dfd353f\""},
     {"Cache-Control", "max-age=0, private, must-revalidate"},
     {"X-Request-Id", "9907dbe0-e57b-422a-bf10-af62b7b1b214"},
     {"X-Runtime", "0.109145"},
     {"X-Rack-Cache", "miss"},
     {"Via", "1.1 google"},
     {"Alt-Svc", "clear"},
     {"CF-Cache-Status", "DYNAMIC"},
     {"Expect-CT",
      "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
     {"Server", "cloudflare"},
     {"CF-RAY", "528cefb92ec340c8-HAM"}
   ],
   request: %HTTPoison.Request{
     body: "",
     headers: [],
     method: :get,
     options: [],
     params: %{},
     url: "https://www.codewars.com/api/v1/code-challenges/55b3425df71c1201a800009c"
   },
   request_url: "https://www.codewars.com/api/v1/code-challenges/55b3425df71c1201a800009c",
   status_code: 200
 }}
 ```
