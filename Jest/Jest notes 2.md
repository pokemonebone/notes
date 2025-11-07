# Памятка по тестам

```ts
import { screen } from '@test-utils/index'
screen.debug()
screen.debug(undefined, 10_000) // увеличить лимит
```

## 1. Проверка что текст есть и текста нет.

```ts
const expandButton = screen.getByRole('button', { name: 'далее' })
fireEvent.click(expandButton)

expect(screen.queryByText(shortText)).not.toBeInTheDocument()
expect(queryByRole('button')).toBeNull()
expect(screen.getByText(fullText)).toBeInTheDocument()
expect(getByText(/существует/i)).toBeInTheDocument()

await waitFor(() => {
  const cell = document.querySelector('div[class*="Cell__CellStyled"]')
  expect(container.querySelector('div[class^="Notification-"]')).not.toBeInTheDocument()
})

const submitButton = getByTestId('apply-button')
expect(submitButton).toBeInTheDocument()
fireEvent.click(submitButton)

const embed = document.querySelector('embed')
expect(embed).toBeInTheDocument()
expect(embed).toHaveAttribute('src', 'http://www.asdasd.com')

const badgeElement = getByText(text)
expect(badgeElement.tagName).toBe('A')
expect(badgeElement).toHaveStyle('background-color: rgb(190, 231, 183)')

const rows = getAllByRole('row')
expect(rows).toHaveLength(5)
```

## 2. Првоерка перехода навигации

```ts
const urlParams = new URLSearchParams(window.location.search)
expect(urlParams.get(MODAL_PARAM)).toBe(ModalTypes.CREATE)
```

## 3. API моки и компонента

```ts
jest.mock('@api/attorney/endpoints', () => ({
  __esModule: true,
  default: {
    postCreateAttorney: jest.fn(),
    getActiveCheck: jest.fn(),
  },
}))

jest.mock('../../../widgets/RequestHistory', () => ({
  __esModule: true,
  default: () => <div data-testid='mocked-component-a'>Mocked RequestHistory</div>,
}))

describe('ModalCreate', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    ;(ApiAttorney.getOperationNonStand as jest.Mock).mockResolvedValue(
      mockOperationNonStand
    )
```

## 4. Время моки

```ts
describe('ModalCreate', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    jest.useFakeTimers()
    jest.setSystemTime(new Date('2025-10-10T12:00:00Z'))
  })

  afterEach(() => {
    jest.useRealTimers()
  })
```

## 5. Ввод в поле

```ts
const input = document.getElementById('comment')
expect(input).toBeInTheDocument()
fireEvent.change(input!, { target: { value: text } })
expect(input).toHaveValue(text)
```

## 6. Snapshot

```ts
test('рендерится как ожидается', () => {
  const { container } = render(<StatusBadge>Активен</StatusBadge>)
  expect(container).toMatchSnapshot()
})
```

## 7. Хуки

```ts
jest.mock('@hooks/useDocInfo', () => ({
  __esModule: true,
  default: () => ({ isLoading: false, fullUrl: 'http://www.asdasd.com' }),
}))
```

```ts
beforeEach(() => {
  jest.clearAllMocks()

const mockSetFileErrors = jest.fn()
      setFileProgress: () => {},
      setFileErrors: mockSetFileErrors,
await waitFor(() => {
  expect(mockSetFileErrors).toHaveBeenCalledTimes(2)
  const result1 = mockSetFileErrors.mock.calls[0][0]({})
  expect(result1).toEqual({ xsfomyxrwu: '' })
  const result2 = mockSetFileErrors.mock.calls[1][0](result1)
  expect(result2).toEqual({ xsfomyxrwu: 'Не удалось зарегистрировать файл.' })

  expect(ApiAttorney.deleteDocument).toHaveBeenCalledWith('asdfasdfasdfasdfasdf')
})
```

## 8. Функции

```ts
const handleClose = jest.fn()
<ModalWithConfirm onClose={handleClose} >

expect(handleClose).toHaveBeenCalledTimes(1)
expect(ApiAttorney.postFilesInfo).not.toHaveBeenCalled()
expect(navigate).toHaveBeenCalledWith('/test-path?otherKey=value', undefined)
```

## 9. throw

```ts
describe('GlobalWidgetContext', () => {
  test('Ошибка использования без провайдера', async () => {
    expect(() => {
      render(<TestComp />)
    }).toThrow()
  })
})

function TestComp() {
  useGlobalWidgetContext()
  return <div>TestComp</div>
}
```

---

```ts
const file2 = new File(['test file 2'], 'document.pdf', { type: 'application/pdf' })

const filesInput = document.getElementById('files') as HTMLInputElement
fireEvent.change(filesInput!, {
  target: {
    files: [file1, file2],
  },
})
expect(filesInput!.files).toHaveLength(2)
```
