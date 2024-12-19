'use client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Loader2 } from 'lucide-react';
import { login } from '@/actions/auth/login';
import { useActionState } from 'react';
import Message from './Message';

const initialState = { message: '' };

export default function LoginForm() {
  const [state, loginAction, isPending] = useActionState(login, initialState);

  return (
    <Card className="w-[350px] p-4">
      <CardHeader className="space-y-2">
        <CardTitle>ログイン</CardTitle>
        <CardDescription>アカウントにログインしてください。</CardDescription>
      </CardHeader>
      <form action={loginAction}>
        <CardContent className="space-y-6">
          <div className="grid w-full items-center gap-6">
            <div className="flex flex-col space-y-2">
              <Label htmlFor="username" className="font-medium">ユーザ名</Label>
              <Input
                id="username"
                name="username"
                type="text"
                placeholder="テストユーザー"
                className="transition-colors focus:ring-2 focus:ring-offset-2"
                required
              />
            </div>
            <div className="flex flex-col space-y-2">
              <Label htmlFor="password" className="font-medium">パスワード</Label>
              <Input
                id="password"
                name="password"
                type="password"
                className="transition-colors focus:ring-2 focus:ring-offset-2"
                required
              />
            </div>
          </div>
          {state && 'message' in state && (
            <Message loginResponse={state} className="mt-4" />
          )}
        </CardContent>
        <CardFooter className="flex flex-col pt-4">
          <Button
            className="w-full font-medium transition-colors hover:opacity-90 active:scale-95"
            type="submit"
            disabled={isPending}
          >
            {isPending ? (
              <>
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                ログイン中...
              </>
            ) : (
              'ログイン'
            )}
          </Button>
        </CardFooter>
      </form>
    </Card>
  );
}
