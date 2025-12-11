# Памятка по тестам

```ts
import { screen } from '@test-utils/index'
screen.debug()
screen.debug(undefined, 10_000) // увеличить лимит
```

## Проверка что текст есть и текста нет

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

const cell = document.querySelectorAll('div[class*="Cell__CellStyled"]')
expect(cell.length).toBe(3)
fireEvent.click(cell[1]!)

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

## Проверка перехода навигации

```ts
const urlParams = new URLSearchParams(window.location.search)
expect(urlParams.get(MODAL_PARAM)).toBe(ModalTypes.CREATE)
```

## API моки и компонента

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
    ;(ApiAttorney.getOperationNonStand as jest.Mock).mockResolvedValue({
      success: true,
      data: {},
    })

expect(ApiAttorney.patchAttorney).toHaveBeenCalledWith({})
expect(ApiAttorney.patchAttorney).toHaveBeenCalledTimes(1)

```

## Время моки

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

## Моки таймера setTimeout

```ts
beforeEach(() => {
  jest.useFakeTimers()
})

afterEach(() => {
  jest.useRealTimers()
})

const testButton = screen.getByRole('button', { name: 'TEST' })
fireEvent.click(testButton)

await waitFor(() => {
  expect(Api.getStatus).toHaveBeenCalledTimes(1)
})
jest.runAllTimers()
await waitFor(() => {
  expect(Api.getStatus).toHaveBeenCalledTimes(2)
})

expect(Api.postDocument).toHaveBeenCalledTimes(1)
```

## Ввод в поле

```ts
const input = document.getElementById('comment')
expect(input).toBeInTheDocument()
fireEvent.change(input!, { target: { value: text } })
expect(input).toHaveValue(text)
```

## Snapshot

```ts
test('рендерится как ожидается', () => {
  const { container } = render(<StatusBadge>Активен</StatusBadge>)
  expect(container).toMatchSnapshot()
})
```

## Тест пустоты

```ts
if (expectedText) {
  expect(screen.getByText(expectedText)).toBeInTheDocument()
} else {
  expect(container).toBeEmptyDOMElement()
}
```

## Буфер обмена

```ts
Object.defineProperty(navigator, 'clipboard', {
  value: {
    writeText: jest.fn(),
  },
  writable: true,
})

describe('CopyButton', () => {
  afterEach(() => {
    jest.clearAllMocks()
  })

  test('Тест отображения, копирования и тултипа', async () => {
    render(
      <CopyButton textToCopy={textToCopy} textForToast={textForToast} tooltip={tooltip}>
        {contentText}
      </CopyButton>
    )

    const button = screen.getByRole('button')
    expect(button).toBeInTheDocument()
    fireEvent.click(button)
    expect(navigator.clipboard.writeText).toHaveBeenCalledWith(textToCopy)
```

## тоасты

```ts
import { toast } from 'react-toastify'

jest.mock('react-toastify', () => ({
  toast: jest.fn(),
}))

describe('successToast', () => {
  it('вызывает toast с SuccessIcon', () => {
    const message = 'Success message'
    successToast(message)

    const [content, options] = (toast as unknown as jest.Mock).mock.calls[0]

    const children = Array.isArray(content.props.children)
      ? content.props.children
      : [content.props.children]

    expect(content.type).toBe(Content)
    expect(children[0].type).toBe(Text)
    expect(children[0].props.children).toBe(message)
    expect(options.icon.type).toBe(SuccessIcon)
  })
```

```ts
const button = screen.getByRole('button')
fireEvent.click(button)
await Promise.resolve()
expect(navigator.clipboard.writeText).toHaveBeenCalledWith(textToCopy)
expect(toast).toHaveBeenCalledTimes(1)

fireEvent.mouseEnter(button)
await waitFor(() => {
  expect(screen.getByText(tooltip)).toBeInTheDocument()
})
fireEvent.mouseLeave(button)
await waitFor(() => {
  expect(screen.queryByText(tooltip)).not.toBeInTheDocument()
})
```

## Хуки

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

```ts
const mockUseDocInfo = jest.fn()

jest.mock('@hooks/useDocInfo', () => ({
  __esModule: true,
  default: () => mockUseDocInfo(),
}))

beforeEach(() => {
  mockUseDocInfo
    .mockReturnValueOnce({ isLoading: true, fullUrl: '' })
    .mockReturnValue({ isLoading: false, fullUrl: 'http://www.asdasd.com' })
})
```

## Функции

```ts
const handleClose = jest.fn()
<ModalWithConfirm onClose={handleClose} >

expect(handleClose).toHaveBeenCalledTimes(1)
expect(ApiAttorney.postFilesInfo).not.toHaveBeenCalled()
expect(navigate).toHaveBeenCalledWith('/test-path?otherKey=value', undefined)
```

## throw

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
