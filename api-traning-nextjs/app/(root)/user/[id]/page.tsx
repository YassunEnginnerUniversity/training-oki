import { Button } from "@/components/ui/button"
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar"
import { CalendarIcon, MapPinIcon, LinkIcon } from 'lucide-react'

export default async function UserDetailPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const slug = (await params).id
  return (
    <div className="max-w-3xl mx-auto bg-background">
      <div className="h-48 bg-gray-200">
        <img
          src="/user_kv.jpg"
          alt="Header"
          className="w-full h-full object-cover"
        />
      </div>

      <div className="px-4 py-3 sm:px-6">
        <div className="flex justify-between items-start">
          <div className="-mt-16">
            <Avatar className="w-32 h-32 border-4 border-background">
              <AvatarImage src="https://github.com/shadcn.png" alt="@johndoe" />
              <AvatarFallback>JD</AvatarFallback>
            </Avatar>
          </div>
          <Button className="rounded-full px-6">フォローする</Button>
        </div>

        <div className="mt-4">
          <h1 className="text-xl font-bold">John Doe</h1>
          <p className="text-muted-foreground">@johndoe</p>
        </div>

        <div className="mt-4 text-muted-foreground">
          <p>Web developer, coffee enthusiast, and amateur photographer.</p>
        </div>

        <div className="mt-4 flex flex-wrap gap-4 text-sm text-muted-foreground">
          <div className="flex items-center">
            <MapPinIcon className="w-4 h-4 mr-1" />
            Tokyo, Japan
          </div>
          <div className="flex items-center">
            <LinkIcon className="w-4 h-4 mr-1" />
            <a href="https://johndoe.com" className="text-primary">johndoe.com</a>
          </div>
          <div className="flex items-center">
            <CalendarIcon className="w-4 h-4 mr-1" />
            2010年7月からX（旧Twitter）を利用しています
          </div>
        </div>

        <div className="mt-4 flex gap-4 text-sm">
          <div>
            <span className="font-bold text-foreground">1,234</span>{" "}
            <span className="text-muted-foreground">フォロー中</span>
          </div>
          <div>
            <span className="font-bold text-foreground">5,678</span>{" "}
            <span className="text-muted-foreground">フォロワー</span>
          </div>
        </div>
      </div>
    </div>
  )
}