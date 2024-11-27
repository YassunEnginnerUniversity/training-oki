import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar"
import { CalendarIcon, MapPinIcon } from 'lucide-react'
import FollowButton from "@/components/user/FollowButton"
import { getUser } from "@/actions/user/getUser"
import { formatDate } from "@/utils/formatDate"
import { getCurrentUser } from "@/actions/user/getCurrentUser"
import { generatePokemonIcon } from "@/utils/generatePokemonIcon"
import { redirect } from "next/navigation"

const UserDetailPage = async ({
  params,
}: {
  params: Promise<{ id: string }>
}) =>  {
  const userId = (await params).id
  const user = await getUser(userId);
  const currentUser = await getCurrentUser()

  if(!currentUser) {
    redirect("/login")
  }
  console.log(user);
  
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
            <Avatar className="w-32 h-32 border-4 border-background bg-gray-100">
              <AvatarImage src={`/pokemon/${generatePokemonIcon(user.username)}.png`} alt={user.username} />
              <AvatarFallback>{user.username}</AvatarFallback>
            </Avatar>
          </div>
          {currentUser.id !== user.id && (<FollowButton userId={user.id} isFollowed={user.is_followed_by_current_user}/>)}
        </div>

        <div className="mt-4">
          <h1 className="text-xl font-bold">{user.username}</h1>
          <p className="text-muted-foreground">@{user.username}</p>
        </div>

        <div className="mt-4 text-muted-foreground">
          <p>{user.username}です。日常で何気なく思ったことをポストしてます。</p>
        </div>

        <div className="mt-4 flex flex-wrap gap-4 text-sm text-muted-foreground">
          <div className="flex items-center">
            <MapPinIcon className="w-4 h-4 mr-1" />
            Tokyo, Japan
          </div>
          <div className="flex items-center">
            <CalendarIcon className="w-4 h-4 mr-1" />
            {formatDate(user.created_at)}から利用しています
          </div>
        </div>

        <div className="mt-4 flex gap-4 text-sm">
          <div className="flex gap-1">
            <span className="font-bold text-foreground">{user.following_count}</span>
            <span className="text-muted-foreground">フォロー中</span>
          </div>
          <div className="flex gap-1">
            <span className="font-bold text-foreground">{user.followers_count}</span>
            <span className="text-muted-foreground">フォロワー</span>
          </div>
          <div className="flex gap-1">
            <span className="font-bold text-foreground">{user.posts.length}</span>
            <span className="text-muted-foreground">ポスト</span>
          </div>
        </div>
      </div>
    </div>
  )
}

export default UserDetailPage