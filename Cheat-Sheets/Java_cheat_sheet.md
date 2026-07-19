# Java Cheat Sheet

## Grundtyper

| Typ | Beskrivning |
|---|---|
| `int`, `long`, `short`, `byte` | Heltal (32/64/16/8 bit) |
| `double`, `float` | Flyttal (64/32 bit) |
| `boolean` | `true` / `false` |
| `char` | Ett enskilt tecken |
| `String` | Text (inte en primitiv typ) |

```java
int x = 5;
final int Y = 10;      // konstant
var z = 5;              // typen tolkas automatiskt (bara lokala variabler)
```

---

## Kontrollflöde

```java
if (cond) {
    ...
} else if (cond) {
    ...
} else {
    ...
}

for (int i = 0; i < n; i++) { ... }
for (Type item : collection) { ... }   // enhanced for-loop

while (cond) { ... }
do { ... } while (cond);

switch (x) {
    case 1 -> ...;
    case 2, 3 -> ...;
    default -> ...;
}
```

---

## List

```java
List<String> list = new ArrayList<>();
List<String> immutable = List.of("a", "b", "c");
```

| Metod | Vad den gör |
|---|---|
| `list.add(x)` | Lägger till ett element sist |
| `list.get(i)` | Hämtar elementet på index `i` |
| `list.remove(i)` | Tar bort elementet på index `i` |
| `list.size()` | Antal element |
| `list.contains(x)` | `true` om `x` finns i listan |
| `list.isEmpty()` | `true` om listan är tom |
| `list.indexOf(x)` | Index för `x`, eller `-1` |
| `list.sort(comparator)` | Sorterar listan på plats |

---

## Map

```java
Map<String, Integer> map = new HashMap<>();
Map<String, Integer> immutable = Map.of("a", 1, "b", 2);
```

| Metod | Vad den gör |
|---|---|
| `map.put(k, v)` | Lägger till/uppdaterar värde för nyckel |
| `map.get(k)` | Hämtar värdet för nyckeln (`null` om saknas) |
| `map.getOrDefault(k, def)` | Hämtar värde, annars ett standardvärde |
| `map.containsKey(k)` | `true` om nyckeln finns |
| `map.remove(k)` | Tar bort nyckel-värde-paret |
| `map.keySet()` | Alla nycklar som ett `Set` |
| `map.values()` | Alla värden som en `Collection` |
| `map.merge(k, v, BigDecimal::add)` | Slår ihop nytt värde med befintligt |

---

## Streams

```java
list.stream()
    .filter(x -> x > 0)
    .map(x -> x * 2)
    .sorted()
    .collect(Collectors.toList());
```

| Metod | Vad den gör |
|---|---|
| `.filter(predicate)` | Behåller bara element som matchar villkoret |
| `.map(function)` | Omvandlar varje element |
| `.sorted()` | Sorterar strömmen |
| `.collect(Collectors.toList())` | Samlar tillbaka till en `List` |
| `.reduce(start, (a,b) -> ...)` | Slår ihop alla element till ett värde |
| `.anyMatch(predicate)` | `true` om något element matchar |
| `.count()` | Antal element i strömmen |
| `.forEach(action)` | Kör en åtgärd per element |

---

## String

```java
String s = "Hello World";
```

| Metod | Vad den gör |
|---|---|
| `s.length()` | Antal tecken |
| `s.substring(a, b)` | Delsträng från index a till b |
| `s.toUpperCase()` / `.toLowerCase()` | Gör om till versaler/gemener |
| `s.trim()` / `.strip()` | Tar bort mellanslag i början/slutet |
| `s.split(",")` | Delar upp strängen till en `String[]` |
| `s.contains("x")` | `true` om delsträngen finns |
| `s.isBlank()` | `true` om tom eller bara mellanslag |
| `String.format("%s är %d", namn, ålder)` | Formaterad sträng |
| `String.join(", ", list)` | Slår ihop en lista till en sträng |

---

## Optional

```java
Optional<String> opt = Optional.of("value");
```

| Metod | Vad den gör |
|---|---|
| `opt.isPresent()` | `true` om värde finns |
| `opt.isEmpty()` | `true` om tomt |
| `opt.orElse(def)` | Värdet, eller ett standardvärde |
| `opt.orElseThrow(() -> ...)` | Värdet, eller kastar undantag |
| `opt.map(x -> ...)` | Omvandlar värdet om det finns |

---

## BigDecimal (använd aldrig `double` för pengar!)

```java
BigDecimal a = BigDecimal.valueOf(100);
BigDecimal b = BigDecimal.valueOf(30);
```

| Metod | Vad den gör |
|---|---|
| `a.add(b)` | Addition |
| `a.subtract(b)` | Subtraktion |
| `a.multiply(b)` | Multiplikation |
| `a.divide(b, 2, RoundingMode.HALF_UP)` | Division med decimaler + avrundning |
| `a.compareTo(b)` | Jämför värden (`==` funkar INTE korrekt här) |
| `a.setScale(2, RoundingMode.HALF_UP)` | Sätter antal decimaler |

---

## LocalDate / LocalDateTime

```java
LocalDate today = LocalDate.now();
LocalDate date = LocalDate.of(2026, 7, 19);
```

| Metod | Vad den gör |
|---|---|
| `date.plusDays(1)` | Lägger till dagar |
| `date.isBefore(other)` / `.isAfter(other)` | Jämför datum |
| `YearMonth.from(date)` | Extraherar år+månad från ett datum |
| `LocalDate.parse("2026-07-19")` | Tolkar en textsträng till datum |

---

## Records (Java 16+)

```java
record Point(int x, int y) { }
```
Genererar automatiskt: konstruktor, getters (`x()`, `y()`), `equals`, `hashCode`, `toString`.

---

## Vanliga annoteringar

| Annotering | Betydelse |
|---|---|
| `@Override` | Metoden ersätter en från superklass/interface |
| `@Deprecated` | Markerar som föråldrad |
| `@FunctionalInterface` | Interface med exakt en abstrakt metod |
| `@SuppressWarnings("unchecked")` | Tystar en specifik kompilatorvarning |