# Простая State machine для React

Этот код реализует конечный автомат (state machine) в React-компоненте с использованием хука `useReducer`. Основная цель — строго контролировать допустимые переходы между состояниями интерфейса, чтобы избежать некорректных или неожиданных сценариев. Тип `Status` определяет все возможные состояния приложения: `'idle'` (ожидание), `'key'` (ввод ключа), `'loading'` (загрузка), `'success'` (успех), `'error'` (ошибка) и `'sertError'` (ошибка сертификата). Константа `validTransitions` описывает, из какого состояния в какое можно легально перейти — это центральное правило, обеспечивающее целостность логики.

Редьюсер (`reducer`) проверяет, разрешён ли запрошенный переход: если новое состояние есть в списке допустимых для текущего — переход происходит, иначе — игнорируется с предупреждением в консоль. Это предотвращает баги, связанные с неправильной последовательностью действий пользователя или асинхронных операций. Компонент `StateMachine` управляет отображением различных модальных окон в зависимости от текущего состояния (`status`) и предоставляет обработчики, которые вызывают `dispatch` с нужным статусом, тем самым управляя потоком взаимодействия. Такой подход делает поведение интерфейса предсказуемым, легко тестируемым и сопровождаемым.

```ts
type Status = 'idle' | 'key' | 'loading' | 'success' | 'error' | 'sertError'

const validTransitions: Record<Status, Status[]> = {
  idle: ['key'],
  key: ['sertError', 'loading', 'idle'],
  loading: ['success', 'error'],
  success: [],
  error: ['idle'],
  sertError: ['idle'],
}

const reducer = (state: Status, action: Status): Status => {
  if (validTransitions[state].includes(action)) {
    console.log(`Переход из ${state} на ${action}`)
    return action
  }

  console.warn(`Неправильный переход из "${state}" на "${action}"`)
  return state // Игнорируем недопустимое действие
}

export function StateMachine({ onClose }: Props) {
  const [status, dispatch] = useReducer(reducer, 'idle')

  if (status === 'success') {
    successToast(`Задача выполнена`)
  }

  return (
    <>
      <Modal
        title='Простой'
        isTransparentOverlay={status !== 'idle'}
        buttons={{
          apply: {
            onClick: () => {
              dispatch('key') // переход на key
            },
          },
        }}
      >
        <PdfEmbedViewer file={fullUrl} />
      </Modal>

      {status === 'key' && (
        <ModalKey
          onOk={() => {
            dispatch('loading')
          }}
          onCancel={() => {
            dispatch('idle')
          }}
        />
      )}

      {status === 'sertError' && (
        <ModalSertError
          onOk={() => {
            alert('ПЕРЕХОД КУДА ТО')
          }}
          onCancel={() => {
            dispatch('idle')
          }}
        />
      )}

      {status === 'error' && (
        <ModalError
          onOk={() => {
            dispatch('idle')
          }}
          onCancel={() => {
            closeModal()
          }}
        />
      )}

      {status === 'loading' && <ModalProgress />}
    </>
  )
}
```
