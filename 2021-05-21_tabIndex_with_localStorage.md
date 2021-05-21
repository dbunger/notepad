
## How to store a tab specific id for the same customer

Usecase: The same app might run in different tabs and cannot share the same session cookie. So we use a session cookie plus a sessionStorage.tabIndex ...

## Session vs LocalStorage

* [SessionStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage)
  * => dies when tab is closed
  * => survives tab reload
  * => stays even when tab is cloned/dupicated (very cool)
* [LocalStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage)
  * => never expires

## Example / Spike

Just a div to show the value:

```
    <div id="tabIndex"></div>
```

and then some JS:

```
if (!sessionStorage.getItem("tabIndex")) {
  sessionStorage.setItem("tabIndex", "Hey" + ((new Date()) - (new Date().setHours(0,0,0,0))));
}

document.getElementById('tabIndex').innerText=sessionStorage.getItem("tabIndex");
```

Then you get some HTML like

```
    <div id="tabIndex">Hey833234125</div>
```

This number is actually just the ms since midnight ...

And it keeps that value at F5 ... very nice. Also while cloning the tab.

But not on new tab ... then you get another tabIndex ...