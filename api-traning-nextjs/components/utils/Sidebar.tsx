import { Home, Bell, Mail, BookmarkIcon, User, Settings } from 'lucide-react'
import { Button } from "@/components/ui/button"

export const Sidebar = () => {
  const sidebarItem = [
    { icon: Home, label: 'ホーム' },
  ]

  return (
    <div className="w-64 h-screen bg-background border-r fixed top-[92px] left-0 bg-white z-10 overflow-y-auto">
      <div className="p-4">
        <nav className="space-y-2">
          {sidebarItem.map((item) => (
            <Button
              key={item.label}
              variant="ghost"
              className="w-full justify-start text-lg font-medium"
            >
              <item.icon className="mr-4 h-6 w-6" />
              {item.label}
            </Button>
          ))}
        </nav>
      </div>
    </div>
  )
}

