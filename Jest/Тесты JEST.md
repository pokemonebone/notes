#тест #React #JEST

[[Тесты JEST Waiting for appearance]]
[Debugging Troubleshooting · Jest](https://jestjs.io/docs/troubleshooting)

---
## container_querySelector

```ts
  test('Badge renders with 0 value', () => {
    const { container } = render();
    const badge = container.querySelector('span');
    expect(badge).toBeInTheDocument();
  });
```

## getByTestId / toContainHTML

```jsx
const { getByTestId } = render(
  <Button data-testid="button">
	<span data-testid="child" />
  </Button>
);
const buttonElement = getByTestId('button');
expect(buttonElement).toContainHTML('<span data-testid="child"/>');
```

```tsx
const startIcon = <span data-testid="start-icon" />;
const buttonText = 'Click Me';
const { getByTestId } = render(
  <Button
	data-testid="button"
	{buttonText}
  </Button>
);
const buttonElement = getByTestId('button');
expect(buttonElement).toContainElement(getByTestId('start-icon'));
```

## each

```js
  describe('Class test', () => {
    test.each([
      {
        type: 'primary',
      },
      {
        type: 'secondary',
      },
      {
        type: 'ghost',
      },
      {
        type: 'error',
      },
      {
        type: 'outline',
      },
    ])('Button style: $type', ({ type }) => {
      const { getByText } = render(
        <Button type={type as ButtonTypes}>{type}</Button>
      );
      expect(getByText(type)).toHaveClass(type);
    });
  });
```
`src\components\Button\__tests__\Button.test.tsx`
`src\components\Container\__test__\Container.test.tsx`
`src\components\Pagination\__test__\Pagination.test.tsx`

```js
describe('Class test', () => {
  test.each([
    {
      props: {},
      expected: 'toast default',
    },
    {
      props: { type: 'default' } as ToastContainerProps,
      expected: 'default',
    },
    {
      props: { type: 'error' } as ToastContainerProps,
      expected: 'error',
    },
  ])('Toast style: $expected', ({ props, expected }) => {
    renderToastContainer(props);
    fireEvent.click(screen.getByRole('button'));
    expect(screen.getByText('Toast message')).toHaveClass(expected);
  });
});
```
`src\components\Toast\__test__\Toast.test.tsx`
`src\components\Tooltip\__tests__\Tooltip.test.tsx`

## toBeChecked

```js
const checkbox = getByLabelText('Test Label');
expect(checkbox).not.toBeChecked();
fireEvent.click(checkbox);
expect(checkbox).toBeChecked();
```

```js
const o2 = getByLabelText('Option 2');
expect(o2).toBeDisabled();
expect(o2).not.toBeChecked();
o2.click();
expect(o2).not.toBeChecked();
expect(handleChange).toHaveBeenCalledTimes(0);
```
`src\components\Radio\__test__\Radio.test.tsx`
## toHaveBeenCalledWith

```js
const handleChange = jest.fn();
const { container, getByText } = render(
  <Select onChange={handleChange} />);
fireEvent.click(getByText('Monthly'));
expect(handleChange).toHaveBeenCalledTimes(1);
expect(handleChange).toHaveBeenCalledWith(['M1']);
```
`src\components\Select\__tests__\Select.test.tsx`

```js
const handleChange = jest.fn();
fireEvent.click(getByLabelText('Option 4 text'));
expect(handleChange).toHaveBeenCalledTimes(1);
expect(handleChange).toHaveBeenCalledWith('option4');
handleChange.mockClear();
fireEvent.click(getByLabelText('Option 2'));
expect(handleChange).toHaveBeenCalledWith('option2');
expect(handleChange).toHaveBeenCalledTimes(1);
```
`src\components\Radio\__test__\Radio.test.tsx`

## renderContainer

```jsx
function renderContainer(props: ContainerProps) {
  return render(
    <Container {...props}>
      <div>Container content</div>
    </Container>
  );
}
```
`src\components\Container\__test__\Container.test.tsx`

## toHaveValue

```js
const input = getByLabelText('Test Label');
fireEvent.change(input, { target: { value: 'Test Value' } });
expect(input).toHaveValue('Test Value');
```

## waitFor

```js
  fireEvent.click(closeModal);
  fireEvent.click(childrenClose);
  await waitFor(() => {
    expect(handleClose).toHaveBeenCalledTimes(2);
  });
```
`src\components\Modal\__test__\Modal.test.tsx`

```js
// jest.setTimeout(20000);
  await waitFor(
    () => {
      expect(screen.queryByText('Toast message')).not.toBeInTheDocument();
    },
    { timeout: 5000 }
  );
```
`src\components\Toast\__test__\Toast.test.tsx`

## Apply custom className

```js
  test('Apply custom className', () => {
    const { container } = render(
      <Radio
        className="customClassName"
      />
    );
    expect(container.querySelector('.container')).toHaveClass(
      'customClassName'
    );
  });
```

## Apply custom styles

```js
  test('Apply custom styles', () => {
    const { getByRole } = render(
      <Radio
        style={{ color: 'red' }}
      />
    );
    const fieldset = getByRole('group');
    expect(fieldset).toHaveStyle({ color: 'red' });
  });
```

## Подмена даты

```tsx
  test('Render Range mode after click on input', () => {
    jest.useFakeTimers()
    jest.setSystemTime(new Date(2024, 8, 14));

    const { getByText } = render(
      <DatePicker />
    );

    expect(getByText('2024')).toBeInTheDocument();
    expect(getByText('Сентябрь')).toBeInTheDocument();
        
    jest.useRealTimers();
  });
```
`src\components\DatePicker\__test__\DatePicker.test.tsx`

## scrollTo

```ts
window.HTMLElement.prototype.scrollTo = jest.fn();
```
