#ifndef CREDENTIALFILTERMODEL_H
#define CREDENTIALFILTERMODEL_H

#include <QSortFilterProxyModel>

class CredentialFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QString searchText READ searchText WRITE setSearchText NOTIFY searchTextChanged)
public:
    explicit CredentialFilterModel(QObject *parent =nullptr);

    QString searchText()const;
    void setSearchText(const QString &text);

signals:
    void searchTextChanged(const QString &text);

protected:
    bool filterAcceptsRow(int sourceRow,const QModelIndex &sourceParent)const override;

private:
    QString m_searchText;
};

#endif // CREDENTIALFILTERMODEL_H
