#Storybook 

```tsx
export const Success = BadgeStoryTemplate.bind({});
Success.args = {
  status: 'success',
  count: 0,
  showZero: true,
};

Success.decorators = [
  Story => {
    const newArgs = Story().props as BadgeProps;
    return (
      <div style={{ display: 'flex', gap: '20px', alignItems: 'center' }}>
        <Badge {...newArgs} children={'Badge'} />
        <Badge {...newArgs} children={'Badge'} size={'small'} />
        <Badge {...newArgs} children={null} />
        <Badge {...newArgs} size={'small'} children={null} />
      </div>
    );
  },
];
```
`src\components\Badge\Badge.stories.tsx`
