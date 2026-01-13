#import "template.typ": project
#show: project

// --- Title ---
#align(center)[
  #text(size: 18pt, weight: "bold")[Technical Document Template]
  #v(0.5em)
  #text(size: 12pt, style: "italic")[A Small Example]
]

#line(length: 100%, stroke: 1pt + gray)
#v(1em)

= My Technical Document

It is amazing how easy it is to document `python` setups now. 

To start a server, I just run:

```bash
python3 -m http.server 8080
```

Then I can visit http://localhost:8080/ to see the result.

I can also reference variables like `foo` or `bar` inline without breaking my
flow.
