# JPA / Hibernate Cheat Sheet

## Grundläggande Entity

```java
@Entity
@Table(name = "person")   // valfritt, annars används klassnamnet (gemener)
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "full_name", nullable = false, length = 255)
    private String name;

    protected Person() { }   // krävs av JPA, no-arg-konstruktor
}
```

---

## GenerationType (hur ID:n genereras)

| Strategi | Betydelse |
|---|---|
| `IDENTITY` | Databasens auto-increment (t.ex. Postgres `BIGSERIAL`) |
| `SEQUENCE` | En separat sekvens-tabell/objekt i databasen |
| `AUTO` | JPA-providern väljer strategi själv |
| `TABLE` | Använder en egen tabell för att hålla koll på ID:n (ovanligt) |

---

## Relationer

```java
@ManyToOne
private Account account;              // FK-kolumn: account_id (default)

@ManyToOne
@JoinColumn(name = "paid_by_id")      // explicit FK-kolumnnamn
private Person paidBy;

@OneToMany(mappedBy = "account")      // "inverse side", ingen egen FK-kolumn
private List<Expense> expenses;

@ManyToMany
@JoinTable(
    name = "account_person",
    joinColumns = @JoinColumn(name = "account_id"),
    inverseJoinColumns = @JoinColumn(name = "person_id")
)
private List<Person> persons = new ArrayList<>();

@ManyToMany(mappedBy = "persons")     // inverse side av many-to-many
private List<Account> accounts = new ArrayList<>();
```

| Relation | Betyder |
|---|---|
| `@ManyToOne` | Många av denna entitet hör till en av den andra |
| `@OneToMany` | En av denna entitet har många av den andra |
| `@ManyToMany` | Många-till-många, kräver en join-tabell |
| `@OneToOne` | En-till-en-relation |

---

## Fetch-typer

| Typ | Betyder | Default för |
|---|---|---|
| `FetchType.EAGER` | Laddas direkt tillsammans med föräldern | `@ManyToOne`, `@OneToOne` |
| `FetchType.LAZY` | Laddas först när den faktiskt används | `@OneToMany`, `@ManyToMany` |

```java
@ManyToOne(fetch = FetchType.LAZY)   // överskriver default
```

---

## Bean Validation

| Annotering | Betyder |
|---|---|
| `@NotNull` | Värdet får inte vara `null` |
| `@NotBlank` | Sträng: inte `null`, inte tom, inte bara mellanslag |
| `@NotEmpty` | Collection/sträng: inte `null`, inte tom |
| `@Email` | Måste se ut som en giltig e-postadress |
| `@Min(0)` / `@Max(100)` | Numeriska gränser |
| `@DecimalMin("0.0")` | Nedre gräns för `BigDecimal` |
| `@Size(min=1, max=255)` | Längd-/storleksgräns |
| `@Past` / `@Future` | Datum måste vara i förfluten/framtida tid |

```java
public ResponseEntity<?> create(@Valid @RequestBody Person person) { ... }
```

---

## Repositories (Spring Data JPA)

```java
public interface PersonRepository extends JpaRepository<Person, Long> {

    List<Person> findByName(String name);
    Optional<Person> findByEmail(String email);
    boolean existsByEmail(String email);

    @Query("SELECT p FROM Person p WHERE p.email = :email")
    Optional<Person> findCustom(@Param("email") String email);
}
```

| Inbyggd metod | Vad den gör |
|---|---|
| `repo.save(entity)` | Sparar (insert eller update) |
| `repo.findById(id)` | Hämtar en post, returnerar `Optional` |
| `repo.findAll()` | Hämtar alla poster |
| `repo.deleteById(id)` | Tar bort en post |
| `repo.count()` | Antal poster i tabellen |

---

## application.properties

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/dbname
spring.datasource.username=user
spring.datasource.password=pass

spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
```

| `ddl-auto`-värde | Betyder |
|---|---|
| `none` | Hibernate rör inte schemat alls |
| `validate` | Kontrollerar att schema matchar entiteter, ändrar inget |
| `update` | Lägger till saknade tabeller/kolumner, tar aldrig bort |
| `create` | Tar bort och skapar om schemat vid varje start (data försvinner!) |
| `create-drop` | Som `create`, men tar även bort vid avstängning (används i tester) |

---

## Vanliga fallgropar

- **Glömmer `equals()`/`hashCode()` baserat på `id`** → trasigt beteende i `Set`/`Map`
- **N+1-problemet**: att loopa över en `LAZY`-collection triggar en fråga per element → lös med `JOIN FETCH` eller `@EntityGraph`
- **Reserverade SQL-ord** som tabellnamn (`user`, `order`) → använd `@Table(name = "...")`
- **`BigDecimal`-division utan `RoundingMode`** → kastar `ArithmeticException`