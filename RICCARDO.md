# Helvetic Ruby workshop

Riccardo doensloaded the original repo.

* `rbenv install 3.3.3`

## hotwire

has 3 parts:

1. ❌ **Native** handles  Mobile. Skip today
2. ❌ **stimulus**: way it handles javascript - skip today
3. 👍 **Turbo**. min part of the day. every ROR dev SHOJLD know.

## Tubro

want to make user more comfortbale. What if we dont need a full page reload?

## **Turbo Drive**

Optimizes 💩 out of it.

We click the link and turbo overrides the DFLT behaviour. it rewrites this behaviour and updates the history, the API,
so there's a change in the URL, you think it all works as usuakl, then turno does thje same request on his own.
instead of GET, it does FETCH.
when its rendered on server, Tubro detexts this change. if the same JS style on same page, it wont replace it,
it will just give the HTML. or download the IMG we were missing, but wont re fetch the new one.

* This happens automatically if you include hotwire-turbio. Just add yourself. You can disable it, in new turbo.
* To disable it, just add `<body data-turbo="false">` or in a div.

## **Turbo frames**

Then we have **Turbo frames**.

They isolate some partial diffs and replace JUST this one, like 💨 **Turbo Drive**.

* IDs need to be consistent. If frame id tag doesnt stay the same, you get "Content Missing error".

We need 2 methods:

1. TurboFrame helkper which is used in the VIEW
2. `dom_id()` method. works with all models. From `"Card.find(45)"` -> `card_45`.

## Exercise 1. lets implement one with EDIT IN PLACE

done. Wow, it works!

## exercise 2

done

## 3

done

woopsie! Content missing

![Content missing error! Working as intended](image.png)

there is a special frame called `_top`.

## Turbo Streams

### TS.Task1 Task 1: Fix deleting cards



## Task 4: Create new Cards with Turbo Streams

Wow, this is the MOST advanced. You click on + icon, you dont want to create a create in place.
which is cool!

1. lets wrap the + button ina  turbo frame, this time for CREATE not EDIT.
2. Make sure our server renders the oproiper turbo stream that will add the newly created card to the columna nd will render the plux button.


