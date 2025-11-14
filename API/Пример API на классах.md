# Пример оформления API запросов

## Пример использования без try catch 

```ts
setUsers([])
setIsLoading(true)
setError(null)

const requests = await ApiUsers.getUsers()

if (requests.success) {
  setUsers(requests.data.users)
} else {
  setError(requests.error.data.message)
}
setIsLoading(false)

...
const res = await ApiUsers.getUsers()
if (!res.success) {
  setIsError(true)
  setSubmitting(false)
  return
}

closeModal()
```

## Основное хранилище функций доступа в виде класса

```ts
const BASE = 'api/v1/users/'

export default class ApiUsers {
  static getUsers = withErrorHandling(async (): Promise<Users> => {
    return api.get(`${BASE}list`).json()
  })

  static postUser = withErrorHandling(async (data: User) => {
    return api.post(`${BASE}create`, { json: data }).json()
  })
}
```

## Служебная функция-обертка для обработки ошибок стандартным способом

```ts
type ErrorResponce = {
  message: string
  timestamp: string
}

type ErrorReport = {
  data: ErrorResponce
  response: Response
}

type AsyncFunction<T extends any[], R> = (...args: T) => Promise<R>
type Success<T> = { success: true; data: T }
type Failure = { success: false; error: ErrorReport }
type Result<T> = Success<T> | Failure

export default function withErrorHandling<T extends any[], R>(
  asyncFn: AsyncFunction<T, R>
): (...args: T) => Promise<Result<R>> {
  return async (...args: T): Promise<Result<R>> => {
    try {
      const data = await asyncFn(...args)

      return { success: true, data }
    } catch (error: unknown) {
      const httpError = error as HTTPError
      let errorText = ''
      const errorBody = (await httpError.response.json()) as ErrorResponce
      console.error('Error details:', errorBody)
      errorText = `HTTP Error: ${httpError.response.status} - ${httpError.response.statusText}`
      errorToast(errorText)

      return {
        success: false,
        error: { data: errorBody, response: httpError.response },
      }
    }
  }
}
```
