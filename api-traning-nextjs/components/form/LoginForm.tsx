'use client'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { login } from '@/actions/auth'
import { useActionState } from 'react'

const initialState= {message: ""}

export default function LoginForm() {
  const [state, loginAction, isPending] = useActionState(login, initialState)

  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>ログイン</CardTitle>
        <CardDescription>アカウントにログインしてください。</CardDescription>
      </CardHeader>
      <form action={loginAction}>
        <CardContent>
          <div className="grid w-full items-center gap-4">
            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="username">ユーザ名</Label>
              <Input id="username" name="username" type="text" placeholder="テストユーザー" required />
            </div>
            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="password">パスワード</Label>
              <Input id="password" name="password" type="password" required />
            </div>
          </div>
        </CardContent>
        <CardFooter className="flex flex-col">
          <Button className="w-full" type="submit">
            ログイン
          </Button>
        </CardFooter>
      </form>
    </Card>
  )
}