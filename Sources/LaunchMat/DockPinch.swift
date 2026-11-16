import AppKit

// 读取系统捏合控制事件。私有符号缺失时放行，避免误拦截其他系统手势。
enum DockPinch {
    struct Sample {
        let progress: Double
        let phase: Int64
    }
    private typealias GetHID = @convention(c) (CGEvent) -> Unmanaged<CFTypeRef>?
    private typealias GetType = @convention(c) (UnsafeRawPointer) -> UInt32
    private typealias GetInteger = @convention(c) (UnsafeRawPointer, UInt32) -> Int
    private typealias GetFloat = @convention(c) (UnsafeRawPointer, UInt32) -> Double
    private typealias GetOptions = @convention(c) (UnsafeRawPointer) -> UInt32
    private static let library = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_LAZY)
    private static func symbol<T>(_ name: String, _: T.Type) -> T? {
        let handle = UnsafeMutableRawPointer(bitPattern: -2)
        guard let address = dlsym(handle, name) ?? dlsym(library, name) else { return nil }
        return unsafeBitCast(address, to: T.self)
    }
    private static let getHID = symbol("CGEventCopyIOHIDEvent", GetHID.self)
    private static let getType = symbol("IOHIDEventGetType", GetType.self)
    private static let getInteger = symbol("IOHIDEventGetIntegerValue", GetInteger.self)
    private static let getFloat = symbol("IOHIDEventGetFloatValue", GetFloat.self)
    private static let getOptions = symbol("IOHIDEventGetEventFlags", GetOptions.self)

    // DockSwipe 类型为 23，字段基址为事件类型左移 16 位。
    static func read(_ event: CGEvent) -> Sample? {
        guard event.type.rawValue == 30 else { return nil }
        if #available(macOS 27, *) {
            guard let owned = getHID?(event)?.takeRetainedValue() else { return nil }
            return withExtendedLifetime(owned) {
            let hid = UnsafeRawPointer(Unmanaged.passUnretained(owned).toOpaque())
            guard getType?(hid) == 23,
                  getInteger?(hid, (23 << 16) + 1) == 3,
                  let progress = getFloat?(hid, (23 << 16) + 2),
                  let options = getOptions?(hid), progress.isFinite else { return nil }
            return Sample(progress: progress, phase: Int64((options >> 24) & 15))
            }
        }
        guard event.getIntegerValueField(CGEventField(rawValue: 110)!) == 23,
              event.getIntegerValueField(CGEventField(rawValue: 123)!) == 3 else { return nil }
        return Sample(progress: event.getDoubleValueField(CGEventField(rawValue: 124)!),
                      phase: event.getIntegerValueField(CGEventField(rawValue: 132)!))
    }
}
