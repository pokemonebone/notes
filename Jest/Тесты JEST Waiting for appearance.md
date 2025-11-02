#тест #React #JEST

# Waiting for appearance

Appearance and Disappearance | Testing Library https://testing-library.com/docs/guide-disappearance/

### Using `findBy` Queries

```js
test('movie title appears', async () => {
  // element is initially not present...
  // wait for appearance and return the element
  const movie = await findByText('the lion king')
})
```

### Using `waitFor`

```js
test('movie title appears', async () => {
  // element is initially not present...
  // wait for appearance inside an assertion
  await waitFor(() => {
    expect(getByText('the lion king')).toBeInTheDocument()
  })
})
```

## Waiting for disappearance

```js
test('movie title no longer present in DOM', async () => {
  // element is removed
  await waitForElementToBeRemoved(() => queryByText('the mummy'))
})
```

```js
test('movie title goes away', async () => {
  // element is initially present...
  // note use of queryBy instead of getBy to return null
  // instead of throwing in the query itself
  await waitFor(() => {
    expect(queryByText('i, robot')).not.toBeInTheDocument()
  })
})
```

## Asserting elements are not present

```js
const submitButton = screen.queryByText('submit')
expect(submitButton).toBeNull() // it doesn't exist
```

```js
const submitButtons = screen.queryAllByText('submit')
expect(submitButtons).toHaveLength(0) // expect no elements
```

### `not.toBeInTheDocument`

```js
import '@testing-library/jest-dom'
// use `queryBy` to avoid throwing an error with `getBy`
const submitButton = screen.queryByText('submit')
expect(submitButton).not.toBeInTheDocument()
```
