#ifndef PVOBJECT_H
#define PVOBJECT_H

#include <QObject>
#include <QVariant>
#include <QStringList>
#include <QQmlParserStatus>
#include <QDateTime>

#include <cadef.h>
#include <alarm.h>

#define ENTER_CA \
    if(m_cac)\
    {ca_attach_context(m_cac);{

#define LEAVE_CA \
    }}

class QQuickPvObject : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)

    Q_ENUMS(FieldType)
    Q_ENUMS(Severity)

    // Configuration
    Q_PROPERTY(QString channel READ channel WRITE setChannel)
    Q_PROPERTY(bool monitor READ monitor WRITE setMonitor NOTIFY monitorChanged)
    // Information
    Q_PROPERTY(QVariant value   READ value WRITE setValue NOTIFY valueChanged DESIGNABLE false)
    Q_PROPERTY(QString host    MEMBER _host CONSTANT DESIGNABLE false)

    Q_PROPERTY(bool connected   MEMBER  _connected NOTIFY connectionChanged DESIGNABLE false)

    Q_PROPERTY(int severity     MEMBER _severity NOTIFY statusChanged DESIGNABLE false)
    Q_PROPERTY(int status       MEMBER _status NOTIFY statusChanged DESIGNABLE false)

    Q_PROPERTY(bool readable    MEMBER _readable NOTIFY accessChanged DESIGNABLE false)
    Q_PROPERTY(bool writable    MEMBER _writable NOTIFY accessChanged DESIGNABLE false)

    Q_PROPERTY(int count        MEMBER _count CONSTANT DESIGNABLE false)
    Q_PROPERTY(QString units    MEMBER _units CONSTANT DESIGNABLE false)
    Q_PROPERTY(int prec         MEMBER _precision CONSTANT DESIGNABLE false)
    Q_PROPERTY(int nostr        MEMBER _nostr CONSTANT DESIGNABLE false)
    Q_PROPERTY(QStringList strs MEMBER _strs CONSTANT DESIGNABLE false)
    Q_PROPERTY(int type         MEMBER _type CONSTANT DESIGNABLE false)

    Q_PROPERTY(QVariant upctrllim MEMBER _upctrllim CONSTANT DESIGNABLE false)
    Q_PROPERTY(QVariant loctrllim MEMBER _loctrllim CONSTANT DESIGNABLE false)
    Q_PROPERTY(QVariant updisplim MEMBER _updisplim CONSTANT DESIGNABLE false)
    Q_PROPERTY(QVariant lodisplim MEMBER _lodisplim CONSTANT DESIGNABLE false)

    Q_PROPERTY(QDateTime stamp READ stamp WRITE setStamp NOTIFY stampChanged DESIGNABLE false)
public:
    explicit QQuickPvObject(QObject *parent = 0);
    ~QQuickPvObject();

    virtual void classBegin();
    virtual void componentComplete();

    enum FieldType {
        String = 0,
        Integer = 1,
        Short = 1,
        Float = 2,
        Enum = 3,
        Char = 4,
        Long = 5,
        Double = 6,
        Invalid = 7,
    };

    enum Severity {
        NoAlarm = 0,
        MinorAlarm,
        MajorAlarm,
        InvalidAlarm,
    };


    /* connection management */
    long connect(const char *name);
    long disconnect();

    /* subscription management */
    long subscribe(unsigned long = 0);
    long unsubscribe();

    /* channel access callbacks */
    void connectCallback(struct connection_handler_args args);
    void getCallback(struct event_handler_args);
    void monitorCallback(struct event_handler_args);

    /* property access functions */
    QVariant value();
    Q_INVOKABLE void setValue(const QVariant val);
    void updateValue(const QVariant val);

    void * getArrayValue(unsigned long count);

    void setChannel(const QString name);
    QString channel();

    void setMonitor(bool monitor) {_monitor = monitor;}
    bool monitor() {return _monitor;}

    QDateTime stamp() { return _stamp; }
    void setStamp(QDateTime date) { _stamp = date; emit stampChanged(); }

    void updateStatus(int severity, int status);
    void updateAccess(bool read, bool write);

signals:
    void valueChanged();
    void connectionChanged();
    void statusChanged();
    void monitorChanged();
    void accessChanged(bool readable, bool writable);
    void controlLimitChanged();
    void displayLimitChanged();
    void stampChanged();

public slots:


protected:
    /* context */
    static long init_ca();
    static long exit_ca();
    static void exception_handler(exception_handler_args args);

private:
    bool _monitor;

    void * _array;
    QVariant _value;
    QString _name;
    QString _host;

    // pv alarm info
    int _status;            // alarm status
    int _severity;          // alarm severity
    // pv time stamp
    int _sec;               // time stamp - seconds since Midnight Jan.1, 1990
    int _nsec;              // time stamp - nano seconds within second
    QDateTime _stamp;       // date time object
    // pv display info
    FieldType _type;        // field type
    QString _units;         // units
    int _precision;         // precision for float and double type
    int _nostr;             // no. of state strings
    QStringList _strs;      // state strings separated by ;
    QVariant _updisplim;    // upper display limit
    QVariant _lodisplim;    // lower display limit
    QVariant _upalrmlim;    // upper alarm   limit
    QVariant _loalrmlim;    // lower alarm   limit
    QVariant _upwarnlim;    // upper warn    limit
    QVariant _lowarnlim;	// lower warn    limit
    QVariant _upctrllim;    // upper control limit
    QVariant _loctrllim;    // lower control limit

    unsigned long _count;   // number of element

    bool _readable;
    bool _writable;

    bool _connected;        // channel connection status

    chid _chid; // channel id
    evid _evid; // subscription event id
    static struct ca_client_context *m_cac; // global channel access client context

};

#endif // PVOBJECT_H
