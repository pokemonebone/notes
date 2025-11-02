#Storybook

https://storybook.js.org/docs/configure/story-layout

```ts
import type { Meta, StoryObj } from '@storybook/your-framework';
import { Button } from './Button';

const meta: Meta<typeof Button> = {
  component: Button,
};

export default meta;
type Story = StoryObj<typeof Button>;

export const WithLayout: Story = {
  parameters: {
    layout: 'centered',
  },
};
```
