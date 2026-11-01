#import "template.typ": init, warn, note, tip, title_page

#show: init.with(palette: "default")

#title_page("My Title", subtitle: "My Subtitle", logo: "heart.svg")

= My Technical Document

It is amazing how easy it is to document `python` setups now. 

To start a server, I just run:

```bash
python3 -m http.server 8080
```

Then I can visit http://localhost:8080/ to see the result.

I can also reference variables like `foo` or `bar` inline without breaking my
flow.

#note[hi]

#note(title: "Hello")[How are you?]

#warn[Uh oh..]

#tip[It's all good.]
