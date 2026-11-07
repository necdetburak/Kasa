#include "credentialfiltermodel.h"
#include "credentialmodel.h"

CredentialFilterModel::CredentialFilterModel(QObject *parent): QSortFilterProxyModel(parent)
{

}

QString CredentialFilterModel::searchText() const
{
      return m_searchText;
}

void CredentialFilterModel::setSearchText(const QString &text)
{
    if(m_searchText==text)
        return;

    beginFilterChange();
    m_searchText = text;
    endFilterChange();

    emit searchTextChanged(m_searchText);
}


bool CredentialFilterModel::filterAcceptsRow(int sourceRow,const QModelIndex &sourceParent)const
{
    if (m_searchText.isEmpty())
        return true;

    const QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);

    const QString title    = index.data(CredentialModel::TitleRole).toString();
    const QString username = index.data(CredentialModel::UsernameRole).toString();

    return title.contains(m_searchText, Qt::CaseInsensitive)
           || username.contains(m_searchText, Qt::CaseInsensitive);
}
