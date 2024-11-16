import Link from "next/link"
import { Button } from "../ui/button"

interface PageHeaderProps {
  username: string
}

const PageHeader = ({username}: PageHeaderProps) => {
  return (
    <header>
      <div className="flex items-center justify-between px-5 py-8">
        <div className="">
          <h1 className="text-xl">API-Traning-Nextjs</h1>
        </div> 
        <div className="flex items-center gap-6">
          {/* <Button variant="outline" className="justify-self-end">ログイン</Button><div> */}
          <div>
            <Link href={"/"} className="text-base hover:opacity-70">{ username }</Link>
          </div>
          <div>
            <Button className="justify-self-end">ログアウト</Button>
          </div>
        </div>
      </div>
    </header>
  )
}

export default PageHeader