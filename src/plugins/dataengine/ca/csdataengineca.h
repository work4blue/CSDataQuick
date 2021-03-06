#ifndef CSDATAENGINECA_H
#define CSDATAENGINECA_H

#include "csdataengine.h"
struct ca_client_context;

class ObjectModel;

class QCSDataEngineCA : public QCSDataEngine
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "ch.psi.sls.CSDataEngineInterface")
    Q_INTERFACES(QCSDataEngine)

public:
    QCSDataEngineCA(QObject *parent=Q_NULLPTR);
    virtual ~QCSDataEngineCA();

    virtual QString name();
    virtual QString description();

    virtual void create(QCSData *data);
    virtual void close(QCSData *data);
    virtual void setValue(QCSData *data, const QVariant value);
    virtual ObjectModel* allData();

signals:

private slots:
    void notifyDataChange();

protected:
    void timerEvent(QTimerEvent *);

private:
    void dataChanged();

    ObjectModel *_data;
    bool _update_scheduled;
    qint64 _last_update;

    struct ca_client_context *_cac; // global channel access client context
};

#endif // CSDATAENGINECA_H
