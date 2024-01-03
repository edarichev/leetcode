#ifndef EVENTSTESTS_H
#define EVENTSTESTS_H

#include <vector>

class Object
{
public:
};

#define EVENT_IMPL(eventName, eventArgsClass) \
class eventName##EventHandler \
{\
public:\
    eventName##EventHandler(){}\
    virtual ~eventName##EventHandler(){}\
    virtual void call (Object *sender, eventArgsClass *ea) = 0;\
};\
template<typename TClass>\
class eventName##EventHandlerImpl : public eventName##EventHandler\
{\
public:\
    using CallType = void (TClass::*) (Object *sender, eventArgsClass *ea);\
    eventName##EventHandlerImpl(TClass *pObject,\
              CallType callFunction)\
    {\
        _pObject = pObject;\
        _callFunction = callFunction;\
    }\
    virtual void call (Object *sender, eventArgsClass *ea) override\
    {\
        (_pObject->*_callFunction)(sender, ea);\
    }\
private:\
    TClass * _pObject;\
    CallType _callFunction;\
};\
class eventName##Event : public Event<eventName##EventHandler>\
{\
public:\
    void operator() (Object *sender, eventArgsClass *ea)\
    {\
        for (auto &&evt : _eventHandlers)\
            evt->call(sender, ea);\
    }\
};\

template <class TEventHandler>
class Event
{
protected:
    std::vector<TEventHandler*> _eventHandlers;
public:
    Event(){}
    virtual ~Event(){}
    void add(TEventHandler *pHandler)
    {
        _eventHandlers.push_back(pHandler);
    }
    void remove(TEventHandler *pHandler)
    {
        _eventHandlers.remove(pHandler);
    }
    Event &operator+=(TEventHandler *pHandler)
    {
        add(pHandler);
        return *this;
    }
    Event &operator-=(TEventHandler *pHandler)
    {
        remove(pHandler);
        return *this;
    }
};

/**
 * @brief Базовый класс для аргументов какого-либо события
 */
class EventArgs
{
public:
    EventArgs();
    static EventArgs Empty;
};

EVENT_IMPL(Click, EventArgs);

class Widget : public Object
{
public:
    ClickEvent Click;
    ClickEventHandlerImpl<Widget> clickHandler {this, &Widget::btnClick};

    Widget()
    {
        Click += &clickHandler;
    }

private:
    void btnClick(Object */*sender*/, EventArgs */*ea*/)
    {

    }
};

class Gadget : public Widget
{
public:
};



#endif // EVENTSTESTS_H
