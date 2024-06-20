---
title: "Spring Data JPA를 사용하는 최상의 방법"
description: ""
coverImage: "/assets/img/2024-06-19-BestPracticeusingSpringDataJPA_0.png"
date: 2024-06-19 08:23
ogImage: 
  url: /assets/img/2024-06-19-BestPracticeusingSpringDataJPA_0.png
tag: Tech
originalTitle: "Best Practice using Spring Data JPA"
link: "https://medium.com/xtmd/best-practice-using-spring-data-jpa-883c95472274"
---


## 최적 성능을 위해 Spring Data JPA를 숙달하는 방법

![Spring Data JPA](/assets/img/2024-06-19-BestPracticeusingSpringDataJPA_0.png)

백엔드 개발자로서, 우리의 작업은 주로 데이터베이스를 중심으로 합니다. 이 영역에서 Spring Boot는 저가 자주 의지하는 프레임워크입니다. 이 프레임워크의 핵심 구성 요소 중 하나는 데이터 처리에서 뛰어나게 성과를 내는 Spring Data JPA입니다. 이 도구의 중요성은 우리의 개발 과정에서 과소평가될 수 없습니다.

Spring Data JPA는 단순히 도구가 아니라, 복잡한 데이터 관리 작업을 효율적으로 다룰 수 있는 자신감과 능력을 제공해주는 강력한 도구입니다.

<div class="content-ad"></div>


다음은 사람들이 주로 사용하는 기본 어노테이션입니다:

- @Repository: 데이터 액세스 객체(DAO) 역할을 수행하는 클래스를 표시하는 마커 또는 어노테이션입니다.
- @Query: 개발자가 네이티브 쿼리를 사용할 수 있도록 하는 어노테이션입니다.

시간이 지남에 따라, 우리 모두가 일반적인 도전 과제에 직면했습니다. 느린 쿼리, 복잡한 관계 관리, 복잡한 네이티브 쿼리의 이해, 또는 인터페이스 효율성 최적화와 같은 문제입니다. 많은 사람들이 이러한 문제에 직면했고, 우리의 개발 프로세스를 향상시키기 위해 이러한 문제를 해결하는 것이 중요합니다. 이 도전 과제는 당신에게만 해당되는 것이 아닙니다. 우리 모두 함께 이것에 참여하고 있습니다.

# 기본 개념


<div class="content-ad"></div>

Spring Data JPA를 사용할 때, Repository, CrudRepository, PagingAndSortingRepository, 그리고 JpaRepository와 같은 여러 리포지토리 옵션을 사용할 수 있습니다.

## Repository

Repository는 가장 기본적인 인터페이스로써 주로 메서드를 제공하지 않습니다. 어떤 기능도 제공하지 않지만 Spring Data JPA의 모든 다른 리포지토리 인터페이스의 기본 인터페이스 역할을 합니다.

```java
public interface MyRepository extends Repository<MyEntity, Long> {
    // 미리 정의된 메서드 없음
}
```

<div class="content-ad"></div>

이 인터페이스 대신 다른 것을 사용하는 것을 추천합니다. 특정 기능을 제공하는 다른 저장소 인터페이스를 사용하면 더 효율적입니다.

## Crud Repository

CrudRepository 인터페이스는 CRUD (Create, Read, Update, Delete) 작업을 제공합니다. 정렬 또는 페이지네이션 없이 기본 데이터 액세스 기능이 필요하면 좋은 시작점입니다.

```java
public interface MyRepository extends CrudRepository<MyEntity, Long> {
    // 기본 CRUD 메서드가 제공됩니다
}
```

<div class="content-ad"></div>

사용할 수 있는 일반적인 방법들은 다음과 같습니다:

- save(S entity): 주어진 엔티티를 저장합니다.
- findById(ID id): ID로 엔티티를 조회합니다.
- existsById(ID id): 주어진 ID를 가진 엔티티가 있는지 확인합니다.
- findAll(): 모든 엔티티를 반환합니다.
- deleteById(ID id): 주어진 ID를 가진 엔티티를 삭제합니다.

## 페이징 및 정렬 저장소

페이징 및 정렬 저장소는 페이지네이션과 정렬을 위한 메소드를 추가합니다. 이는 대량의 데이터셋을 처리하고 데이터를 페이지에 표시할 때 유용합니다. 이 방법은 또한 CRUD 작업을 종합합니다.

<div class="content-ad"></div>

```java
public interface MyRepository extends PagingAndSortingRepository<MyEntity, Long> {
    // CRUD methods plus paging and sorting
}
```

이 인터페이스는 복잡한 수동 페이지네이션이나 정렬 코드 없이 대량 데이터 집합을 처리하고 페이지에 데이터를 표시하는 편리한 방법을 제공합니다.

이 인터페이스의 추가 메서드는 다음과 같습니다:

- findAll(Pageable pageable): Pageable 객체에서 제공된 페이징 제한을 충족하는 엔티티 페이지를 반환합니다.
- findAll(Sort sort): 주어진 옵션으로 정렬된 모든 엔티티를 반환합니다.

<div class="content-ad"></div>

## Jpa Repository

이 인터페이스는 JPA에 특화된 메서드를 추가하며 일괄 작업, 사용자 정의 쿼리, 플러시와 같은 JPA 관련 메서드의 완전한 집합을 제공합니다. 이는 JPA 응용 프로그램에 가장 강력하고 다재다능한 옵션으로 만듭니다.

```javascript
public interface MyRepository extends JpaRepository<MyEntity, Long> {
    // 전체 CRUD 메서드, 페이징, 정렬 및 JPA에 특화된 메서드
}
```

이 인터페이스는 JPA 관련 작업에 대한 포괄적인 메서드 집합을 제공하여 추가 인터페이스나 사용자 정의 코드 없이도 다양한 작업을 수행할 수 있습니다.

<div class="content-ad"></div>

JpaRepository를 사용하면 findBy 뒤에 속성 이름을 따르는 네이밍 규칙을 적용하여 사용자 정의 쿼리 메서드를 정의할 수 있습니다. Spring Data JPA는 메서드 이름을 기반으로 쿼리를 자동으로 생성할 것입니다.

```js
public interface MyRepository extends JpaRepository<MyEntity, Long> {

    // ID로 엔티티를 찾습니다.
    Optional<MyEntity> findById(Long id);
    
    // 특정 이름을 가진 모든 엔티티를 찾습니다.
    List<MyEntity> findByName(String name);
    
    // 나이가 주어진 값보다 큰 엔티티를 찾습니다.
    List<MyEntity> findByAgeGreaterThan(int age);
    
    // 상태가 활성인 엔티티를 찾습니다.
    List<MyEntity> findByStatus(String status);
}
```

JpaRepository를 선택하는 이유는 무엇인가요?

- 포괄적인 기능: CRUD, 페이지네이션, 정렬 및 JPA 특정 작업을 하나의 인터페이스 내에서 결합합니다.
- 편리함: 필요한 모든 메서드를 제공하여 코드를 단순화합니다.
- 성능: 일괄 작업과 플러시 제어로 성능을 최적화합니다.
- 유연성: 사용자 정의 쿼리 메서드를 지원하며 JPQL(Java Persistence Query Language)과 네이티브 SQL 쿼리를 지원합니다.

<div class="content-ad"></div>

# 스펙 및 기준 빌더 사용

Spring Data JPA를 사용할 때 간단한 쿼리 메서드로 쉽게 구현할 수 없는 더 복잡한 쿼리가 필요할 때가 있습니다. 이때 Specifications 및 Criteria Builder가 등장하여 동적 쿼리를 작성하고 복잡한 시나리오를 처리할 수 있게 해줍니다.

## Specifications

Specifications은 Spring Data JPA의 함수형 인터페이스로, JPA 기준에 따라 동적 쿼리를 생성합니다. 프로그래밍 방식으로 쿼리를 작성하는 방법을 제공합니다. 컴파일 시간에 쿼리 기준이 알려지지 않은 경우 유리합니다.

<div class="content-ad"></div>

스펙이라는 명세는 조건에 기반한 프레디케이트를 구성하는 toPredicate라는 단일 메서드를 갖고 있습니다.

```java
import org.springframework.data.jpa.domain.Specification;
import javax.persistence.criteria.*;

public class MyEntitySpecification {
    public static Specification<MyEntity> hasName(String name) {
        return (Root<MyEntity> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            return cb.equal(root.get("name"), name);
        };
    }
}
```

스펙을 정의한 후에는 해당 스펙을 리포지토리에서 사용할 수 있습니다.

```java
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MyEntityRepository extends JpaRepository<MyEntity, Long>, JpaSpecificationExecutor<MyEntity> {
    // JpaRepository의 메서드 및 JpaSpecificationExecutor의 메서드
}

// 사용 예시
Specification<MyEntity> spec = MyEntitySpecification.hasName("John Doe");
List<MyEntity> results = myEntityRepository.findAll(spec);
```

<div class="content-ad"></div>

## Criteria Builder

Criteria Builder API는 JPA의 일부이며 유형 안정적인 쿼리를 생성할 수 있습니다. 이 API는 하드코딩된 문자열 대신 Java 객체를 사용하여 동적으로 쿼리를 구성하는 방법을 제공합니다.

Criteria Builder를 사용하려면 EntityManager에서 인스턴스를 획들해야 합니다.

```java
import javax.persistence.*;
import javax.persistence.criteria.*;
import java.util.List;

public class MyEntityService {
    @PersistenceContext
    private EntityManager entityManager;

    public List<MyEntity> findByName(String name) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<MyEntity> query = cb.createQuery(MyEntity.class);
        Root<MyEntity> root = query.from(MyEntity.class);

        // 쿼리 구성
        query.select(root).where(cb.equal(root.get("name"), name));

        return entityManager.createQuery(query).getResultList();
    }
}
```

<div class="content-ad"></div>

여러 기준을 결합하여 보다 복잡한 쿼리를 만들 수 있습니다. 예를 들어, and와 or을 사용하여 조건을 결합할 수 있습니다.

```js
public class MyEntitySpecification {
    public static Specification<MyEntity> hasName(String name) {
        return (Root<MyEntity> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            return cb.equal(root.get("name"), name);
        };
    }

    public static Specification<MyEntity> hasStatus(String status) {
        return (Root<MyEntity> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            return cb.equal(root.get("status"), status);
        };
    }

    public static Specification<MyEntity> hasAgeGreaterThan(int age) {
        return (Root<MyEntity> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            return cb.greaterThan(root.get("age"), age);
        };
    }

    public static Specification<MyEntity> hasNameAndStatus(String name, String status) {
        return (Root<MyEntity> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            Predicate namePredicate = cb.equal(root.get("name"), name);
            Predicate statusPredicate = cb.equal(root.get("status"), status);
            return cb.and(namePredicate, statusPredicate);
        };
    }
}

// 사용 예시
Specification<MyEntity> spec = MyEntitySpecification.hasNameAndStatus("John Doe", "active");
List<MyEntity> results = myEntityRepository.findAll(spec);
```

여러 명세를 결합하면 더 유연하고 재사용 가능한 쿼리 조건을 생성할 수 있습니다.

```js
Specification<MyEntity> spec = Specification.where(MyEntitySpecification.hasName("Jane Doe"))
                                            .and(MyEntitySpecification.hasStatus("active"))
                                            .and(MyEntitySpecification.hasAgeGreaterThan(25));
List<MyEntity> results = myEntityRepository.findAll(spec);
```

<div class="content-ad"></div>

# 팁과 요령

Spring Data JPA를 최대한 활용하기 위해 몇 가지 팁과 요령을 따르는 것이 중요합니다. 이를 통해 응용 프로그램을 최적화하고 일반적인 함정을 피하며 코드를 유지보수 가능하고 효율적으로 유지할 수 있습니다.

## 1. Lazy Loading 사용

기본적으로 JPA에서는 관계를 FetchType.LAZY로 설정하여 관련 엔티티가 액세스될 때까지 데이터베이스에서로드되지 않도록 합니다. 이는 자원을 절약할 수 있지만 잘못 처리하면 N+1 셀렉트 문제로 이어질 수도 있습니다.

<div class="content-ad"></div>

최선의 방법: 대형이거나 드물게 액세스되는 관계에 대해 레이지 로딩을 사용하세요. 자주 액세스되는 관계에 대해서는 이저 로딩을 고려해보세요.

```js
@Entity
public class MyEntity {
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "myEntity")
    private List<RelatedEntity> relatedEntities;
}
```

## 2.쿼리 최적화하기

하나의 잘 구성된 쿼리가 역할을 할 수 있는 경우 여러 쿼리를 실행하는 것을 피하세요. 필요한 경우에는 JPQL, Criteria API 또는 네이티브 쿼리를 사용하여 성능을 최적화하세요.

<div class="content-ad"></div>

최선의 방법: 관련 쿼리를 하나의 데이터베이스 조회로 결합하기 위해 사용자 지정 쿼리나 Specification을 사용하세요.

```js
@Query("SELECT e FROM MyEntity e JOIN FETCH e.relatedEntities WHERE e.name = :name")
List<MyEntity> findByNameWithRelatedEntities(@Param("name") String name);
```

## 3. 캐싱 활용하기

캐싱은 데이터베이스 조회 횟수를 줄여 응용 프로그램 성능을 크게 향상시킬 수 있습니다. 스프링은 Ehcache, Hazelcast 등과 같은 캐싱 솔루션과의 쉬운 통합을 제공합니다.

<div class="content-ad"></div>

최선의 실천법: 자주 변경되지 않는 자주 액세스되는 데이터를 캐싱하는 것입니다.

```js
@Cacheable("myEntities")
public List<MyEntity> findAll() {
    return myEntityRepository.findAll();
}
```

## 4. 일괄 처리

여러 엔티티를 저장하거나 삭제할 때 일괄 처리를 사용하면 데이터베이스 라운드트립 수를 줄이고 성능을 향상시킬 수 있습니다.

<div class="content-ad"></div>

최선의 방법: 일괄 삽입에는 saveAll을 사용하고 일괄 삭제에는 deleteInBatch를 사용하세요.

```java
public void saveEntities(List<MyEntity> entities) {
    myEntityRepository.saveAll(entities);
}

public void deleteEntities(List<MyEntity> entities) {
    myEntityRepository.deleteInBatch(entities);
}
```

## 5. 적절한 트랜잭션 관리

데이터 무결성을 유지하기 위해 데이터베이스 작업이 올바르게 트랜잭션으로 래핑되어 있는지 확인하세요. 트랜잭션 관리를 위해 Spring의 Transactional 어노테이션을 사용하세요.

<div class="content-ad"></div>

최선의 방법: 서비스 레이어에서 @Transactional을 사용하여 메소드 내의 모든 작업이 단일 트랜잭션의 일부임을 보장하십시오.

```java
@Service
public class MyEntityService {

    @Transactional
    public void updateEntities(List<MyEntity> entities) {
        for (MyEntity entity : entities) {
            myEntityRepository.save(entity);
        }
    }
}
```

## 6. N+1 선택 문제 피하기

N+1 선택 문제란 애플리케이션이 N개의 엔티티를 얻기 위해 N+1번의 데이터베이스 쿼리를 수행할 때 발생하며, 각각의 관련된 엔티티를 갖게 되어 성능에 심각한 영향을 미칠 수 있습니다.

<div class="content-ad"></div>

안녕하세요! 다음은 코드 스니펫을 한국어로 번역한 것입니다. 

최선의 방법: JPQL 쿼리에 JOIN FETCH를 사용하여 관련 엔티티를 한 번의 쿼리로 가져오세요.

```js
@Query("SELECT e FROM MyEntity e JOIN FETCH e.relatedEntities WHERE e.status = :status")
List<MyEntity> findByStatusWithRelatedEntities(@Param("status") String status);
```

## 7. 로깅 및 모니터링

Hibernate에 의해 생성된 쿼리를 이해하기 위해 개발 중에 SQL 로깅을 활성화하세요. 이는 비효율적인 쿼리를 식별하고 최적화하는 데 도움이 될 수 있습니다.

<div class="content-ad"></div>

좋은 방법: SQL 쿼리와 성능 지표를 모니터링하기 위해 로깅을 사용하세요.

```js
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
```

## 8. 프로젝션 처리

가끔 전체 엔티티가 아닌 몇 가지 필드만 필요할 때가 있습니다. 프로젝션을 사용하여 필요한 데이터만 선택하세요.

<div class="content-ad"></div>

**최상의 실천 방법:** 필요한 필드만 가져오기 위해 프로젝션을 사용하여 데이터베이스에서 전달되는 데이터 양을 줄입니다.

```js
public interface MyEntityProjection {
    String getName();
    String getStatus();
}

@Query("SELECT e.name AS name, e.status AS status FROM MyEntity e WHERE e.age > :age")
List<MyEntityProjection> findNamesAndStatusesByAge(@Param("age") int age);
```

## 9.뷰 사용하기

가끔 선택 쿼리가 더 복잡해질 수 있습니다. 가상 테이블이나 테이블 뷰를 생성하여 데이터 액세스를 간소화할 수 있습니다.

<div class="content-ad"></div>

**Best practice:** 뷰를 사용하면 SELECT 문을 간단하게 만들어 복잡성을 줄이고 잠재적인 오류를 방지할 수 있습니다.

# 결론

Spring Data JPA를 숙달하면 효율적인 애플리케이션 데이터 접근 계층을 개발하는 능력을 크게 향상시킬 수 있습니다. 적절한 리포지토리 인터페이스 사용, 동적 쿼리를 위해 명세서와 조건 빌더 활용, 쿼리와 트랜잭션 최적화 등의 최고의 실천 방법을 따르면 응용 프로그램이 원활하게 작동하고 효과적으로 확장될 수 있습니다.

Spring Data JPA는 강력한 도구이지만, 다른 도구와 마찬가지로 실용적인 이해와 주의가 필요합니다. 팁과 트릭을 적용하고 계속 학습하며 기술을 향상시키면 능숙한 개발자가 되어 사용자의 요구를 충족하는 고품질 애플리케이션을 개발할 수 있습니다.