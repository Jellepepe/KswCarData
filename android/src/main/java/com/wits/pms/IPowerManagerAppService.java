/*
 * This file is auto-generated.  DO NOT MODIFY.
 */
package com.wits.pms;
public interface IPowerManagerAppService extends android.os.IInterface
{
  /** Default implementation for IPowerManagerAppService. */
  public static class Default implements com.wits.pms.IPowerManagerAppService
  {
    @Override public boolean sendCommand(java.lang.String str) throws android.os.RemoteException
    {
      return false;
    }
    @Override public boolean sendStatus(java.lang.String str) throws android.os.RemoteException
    {
      return false;
    }
    @Override public void registerCmdListener(com.wits.pms.ICmdListener iCmdListener) throws android.os.RemoteException
    {
    }
    @Override public void unregisterCmdListener(com.wits.pms.ICmdListener iCmdListener) throws android.os.RemoteException
    {
    }
    @Override public void registerObserver(java.lang.String str, com.wits.pms.IContentObserver iContentObserver) throws android.os.RemoteException
    {
    }
    @Override public void unregisterObserver(com.wits.pms.IContentObserver iContentObserver) throws android.os.RemoteException
    {
    }
    @Override public boolean getStatusBoolean(java.lang.String str) throws android.os.RemoteException
    {
      return false;
    }
    @Override public int getStatusInt(java.lang.String str) throws android.os.RemoteException
    {
      return 0;
    }
    @Override public java.lang.String getStatusString(java.lang.String str) throws android.os.RemoteException
    {
      return null;
    }
    @Override public int getSettingsInt(java.lang.String str) throws android.os.RemoteException
    {
      return 0;
    }
    @Override public java.lang.String getSettingsString(java.lang.String str) throws android.os.RemoteException
    {
      return null;
    }
    @Override public void setSettingsInt(java.lang.String str, int i) throws android.os.RemoteException
    {
    }
    @Override public void setSettingsString(java.lang.String str, java.lang.String str2) throws android.os.RemoteException
    {
    }
    @Override public void addIntStatus(java.lang.String str, int i) throws android.os.RemoteException
    {
    }
    @Override public void addBooleanStatus(java.lang.String str, boolean z) throws android.os.RemoteException
    {
    }
    @Override public void addStringStatus(java.lang.String str, java.lang.String str2) throws android.os.RemoteException
    {
    }
    @Override public void saveJsonConfig(java.lang.String str, java.lang.String str2) throws android.os.RemoteException
    {
    }
    @Override public java.lang.String getJsonConfig(java.lang.String str) throws android.os.RemoteException
    {
      return null;
    }
    @Override
    public android.os.IBinder asBinder() {
      return null;
    }
  }
  /** Local-side IPC implementation stub class. */
  public static abstract class Stub extends android.os.Binder implements com.wits.pms.IPowerManagerAppService
  {
    private static final java.lang.String DESCRIPTOR = "com.wits.pms.IPowerManagerAppService";
    /** Construct the stub at attach it to the interface. */
    public Stub()
    {
      this.attachInterface(this, DESCRIPTOR);
    }
    /**
     * Cast an IBinder object into an com.wits.pms.IPowerManagerAppService interface,
     * generating a proxy if needed.
     */
    public static com.wits.pms.IPowerManagerAppService asInterface(android.os.IBinder obj)
    {
      if ((obj==null)) {
        return null;
      }
      android.os.IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
      if (((iin!=null)&&(iin instanceof com.wits.pms.IPowerManagerAppService))) {
        return ((com.wits.pms.IPowerManagerAppService)iin);
      }
      return new com.wits.pms.IPowerManagerAppService.Stub.Proxy(obj);
    }
    @Override public android.os.IBinder asBinder()
    {
      return this;
    }
    @Override public boolean onTransact(int code, android.os.Parcel data, android.os.Parcel reply, int flags) throws android.os.RemoteException
    {
      java.lang.String descriptor = DESCRIPTOR;
      switch (code)
      {
        case INTERFACE_TRANSACTION:
        {
          reply.writeString(descriptor);
          return true;
        }
        case TRANSACTION_sendCommand:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          boolean _result = this.sendCommand(_arg0);
          reply.writeNoException();
          reply.writeInt(((_result)?(1):(0)));
          return true;
        }
        case TRANSACTION_sendStatus:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          boolean _result = this.sendStatus(_arg0);
          reply.writeNoException();
          reply.writeInt(((_result)?(1):(0)));
          return true;
        }
        case TRANSACTION_registerCmdListener:
        {
          data.enforceInterface(descriptor);
          com.wits.pms.ICmdListener _arg0;
          _arg0 = com.wits.pms.ICmdListener.Stub.asInterface(data.readStrongBinder());
          this.registerCmdListener(_arg0);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_unregisterCmdListener:
        {
          data.enforceInterface(descriptor);
          com.wits.pms.ICmdListener _arg0;
          _arg0 = com.wits.pms.ICmdListener.Stub.asInterface(data.readStrongBinder());
          this.unregisterCmdListener(_arg0);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_registerObserver:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          com.wits.pms.IContentObserver _arg1;
          _arg1 = com.wits.pms.IContentObserver.Stub.asInterface(data.readStrongBinder());
          this.registerObserver(_arg0, _arg1);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_unregisterObserver:
        {
          data.enforceInterface(descriptor);
          com.wits.pms.IContentObserver _arg0;
          _arg0 = com.wits.pms.IContentObserver.Stub.asInterface(data.readStrongBinder());
          this.unregisterObserver(_arg0);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_getStatusBoolean:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          boolean _result = this.getStatusBoolean(_arg0);
          reply.writeNoException();
          reply.writeInt(((_result)?(1):(0)));
          return true;
        }
        case TRANSACTION_getStatusInt:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          int _result = this.getStatusInt(_arg0);
          reply.writeNoException();
          reply.writeInt(_result);
          return true;
        }
        case TRANSACTION_getStatusString:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          java.lang.String _result = this.getStatusString(_arg0);
          reply.writeNoException();
          reply.writeString(_result);
          return true;
        }
        case TRANSACTION_getSettingsInt:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          int _result = this.getSettingsInt(_arg0);
          reply.writeNoException();
          reply.writeInt(_result);
          return true;
        }
        case TRANSACTION_getSettingsString:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          java.lang.String _result = this.getSettingsString(_arg0);
          reply.writeNoException();
          reply.writeString(_result);
          return true;
        }
        case TRANSACTION_setSettingsInt:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          int _arg1;
          _arg1 = data.readInt();
          this.setSettingsInt(_arg0, _arg1);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_setSettingsString:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          java.lang.String _arg1;
          _arg1 = data.readString();
          this.setSettingsString(_arg0, _arg1);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_addIntStatus:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          int _arg1;
          _arg1 = data.readInt();
          this.addIntStatus(_arg0, _arg1);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_addBooleanStatus:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          boolean _arg1;
          _arg1 = (0!=data.readInt());
          this.addBooleanStatus(_arg0, _arg1);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_addStringStatus:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          java.lang.String _arg1;
          _arg1 = data.readString();
          this.addStringStatus(_arg0, _arg1);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_saveJsonConfig:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          java.lang.String _arg1;
          _arg1 = data.readString();
          this.saveJsonConfig(_arg0, _arg1);
          reply.writeNoException();
          return true;
        }
        case TRANSACTION_getJsonConfig:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          java.lang.String _result = this.getJsonConfig(_arg0);
          reply.writeNoException();
          reply.writeString(_result);
          return true;
        }
        default:
        {
          return super.onTransact(code, data, reply, flags);
        }
      }
    }
    private static class Proxy implements com.wits.pms.IPowerManagerAppService
    {
      private android.os.IBinder mRemote;
      Proxy(android.os.IBinder remote)
      {
        mRemote = remote;
      }
      @Override public android.os.IBinder asBinder()
      {
        return mRemote;
      }
      public java.lang.String getInterfaceDescriptor()
      {
        return DESCRIPTOR;
      }
      @Override public boolean sendCommand(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        boolean _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_sendCommand, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().sendCommand(str);
          }
          _reply.readException();
          _result = (0!=_reply.readInt());
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public boolean sendStatus(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        boolean _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_sendStatus, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().sendStatus(str);
          }
          _reply.readException();
          _result = (0!=_reply.readInt());
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public void registerCmdListener(com.wits.pms.ICmdListener iCmdListener) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeStrongBinder((((iCmdListener!=null))?(iCmdListener.asBinder()):(null)));
          boolean _status = mRemote.transact(Stub.TRANSACTION_registerCmdListener, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().registerCmdListener(iCmdListener);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void unregisterCmdListener(com.wits.pms.ICmdListener iCmdListener) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeStrongBinder((((iCmdListener!=null))?(iCmdListener.asBinder()):(null)));
          boolean _status = mRemote.transact(Stub.TRANSACTION_unregisterCmdListener, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().unregisterCmdListener(iCmdListener);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void registerObserver(java.lang.String str, com.wits.pms.IContentObserver iContentObserver) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          _data.writeStrongBinder((((iContentObserver!=null))?(iContentObserver.asBinder()):(null)));
          boolean _status = mRemote.transact(Stub.TRANSACTION_registerObserver, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().registerObserver(str, iContentObserver);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void unregisterObserver(com.wits.pms.IContentObserver iContentObserver) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeStrongBinder((((iContentObserver!=null))?(iContentObserver.asBinder()):(null)));
          boolean _status = mRemote.transact(Stub.TRANSACTION_unregisterObserver, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().unregisterObserver(iContentObserver);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public boolean getStatusBoolean(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        boolean _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_getStatusBoolean, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().getStatusBoolean(str);
          }
          _reply.readException();
          _result = (0!=_reply.readInt());
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public int getStatusInt(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        int _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_getStatusInt, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().getStatusInt(str);
          }
          _reply.readException();
          _result = _reply.readInt();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public java.lang.String getStatusString(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        java.lang.String _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_getStatusString, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().getStatusString(str);
          }
          _reply.readException();
          _result = _reply.readString();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public int getSettingsInt(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        int _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_getSettingsInt, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().getSettingsInt(str);
          }
          _reply.readException();
          _result = _reply.readInt();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public java.lang.String getSettingsString(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        java.lang.String _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_getSettingsString, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().getSettingsString(str);
          }
          _reply.readException();
          _result = _reply.readString();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public void setSettingsInt(java.lang.String str, int i) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          _data.writeInt(i);
          boolean _status = mRemote.transact(Stub.TRANSACTION_setSettingsInt, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().setSettingsInt(str, i);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void setSettingsString(java.lang.String str, java.lang.String str2) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          _data.writeString(str2);
          boolean _status = mRemote.transact(Stub.TRANSACTION_setSettingsString, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().setSettingsString(str, str2);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void addIntStatus(java.lang.String str, int i) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          _data.writeInt(i);
          boolean _status = mRemote.transact(Stub.TRANSACTION_addIntStatus, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().addIntStatus(str, i);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void addBooleanStatus(java.lang.String str, boolean z) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          _data.writeInt(((z)?(1):(0)));
          boolean _status = mRemote.transact(Stub.TRANSACTION_addBooleanStatus, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().addBooleanStatus(str, z);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void addStringStatus(java.lang.String str, java.lang.String str2) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          _data.writeString(str2);
          boolean _status = mRemote.transact(Stub.TRANSACTION_addStringStatus, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().addStringStatus(str, str2);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public void saveJsonConfig(java.lang.String str, java.lang.String str2) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          _data.writeString(str2);
          boolean _status = mRemote.transact(Stub.TRANSACTION_saveJsonConfig, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().saveJsonConfig(str, str2);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      @Override public java.lang.String getJsonConfig(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        java.lang.String _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_getJsonConfig, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().getJsonConfig(str);
          }
          _reply.readException();
          _result = _reply.readString();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      public static com.wits.pms.IPowerManagerAppService sDefaultImpl;
    }
    static final int TRANSACTION_sendCommand = (android.os.IBinder.FIRST_CALL_TRANSACTION + 0);
    static final int TRANSACTION_sendStatus = (android.os.IBinder.FIRST_CALL_TRANSACTION + 1);
    static final int TRANSACTION_registerCmdListener = (android.os.IBinder.FIRST_CALL_TRANSACTION + 2);
    static final int TRANSACTION_unregisterCmdListener = (android.os.IBinder.FIRST_CALL_TRANSACTION + 3);
    static final int TRANSACTION_registerObserver = (android.os.IBinder.FIRST_CALL_TRANSACTION + 4);
    static final int TRANSACTION_unregisterObserver = (android.os.IBinder.FIRST_CALL_TRANSACTION + 5);
    static final int TRANSACTION_getStatusBoolean = (android.os.IBinder.FIRST_CALL_TRANSACTION + 6);
    static final int TRANSACTION_getStatusInt = (android.os.IBinder.FIRST_CALL_TRANSACTION + 7);
    static final int TRANSACTION_getStatusString = (android.os.IBinder.FIRST_CALL_TRANSACTION + 8);
    static final int TRANSACTION_getSettingsInt = (android.os.IBinder.FIRST_CALL_TRANSACTION + 9);
    static final int TRANSACTION_getSettingsString = (android.os.IBinder.FIRST_CALL_TRANSACTION + 10);
    static final int TRANSACTION_setSettingsInt = (android.os.IBinder.FIRST_CALL_TRANSACTION + 11);
    static final int TRANSACTION_setSettingsString = (android.os.IBinder.FIRST_CALL_TRANSACTION + 12);
    static final int TRANSACTION_addIntStatus = (android.os.IBinder.FIRST_CALL_TRANSACTION + 13);
    static final int TRANSACTION_addBooleanStatus = (android.os.IBinder.FIRST_CALL_TRANSACTION + 14);
    static final int TRANSACTION_addStringStatus = (android.os.IBinder.FIRST_CALL_TRANSACTION + 15);
    static final int TRANSACTION_saveJsonConfig = (android.os.IBinder.FIRST_CALL_TRANSACTION + 16);
    static final int TRANSACTION_getJsonConfig = (android.os.IBinder.FIRST_CALL_TRANSACTION + 17);
    public static boolean setDefaultImpl(com.wits.pms.IPowerManagerAppService impl) {
      if (Stub.Proxy.sDefaultImpl == null && impl != null) {
        Stub.Proxy.sDefaultImpl = impl;
        return true;
      }
      return false;
    }
    public static com.wits.pms.IPowerManagerAppService getDefaultImpl() {
      return Stub.Proxy.sDefaultImpl;
    }
  }
  public boolean sendCommand(java.lang.String str) throws android.os.RemoteException;
  public boolean sendStatus(java.lang.String str) throws android.os.RemoteException;
  public void registerCmdListener(com.wits.pms.ICmdListener iCmdListener) throws android.os.RemoteException;
  public void unregisterCmdListener(com.wits.pms.ICmdListener iCmdListener) throws android.os.RemoteException;
  public void registerObserver(java.lang.String str, com.wits.pms.IContentObserver iContentObserver) throws android.os.RemoteException;
  public void unregisterObserver(com.wits.pms.IContentObserver iContentObserver) throws android.os.RemoteException;
  public boolean getStatusBoolean(java.lang.String str) throws android.os.RemoteException;
  public int getStatusInt(java.lang.String str) throws android.os.RemoteException;
  public java.lang.String getStatusString(java.lang.String str) throws android.os.RemoteException;
  public int getSettingsInt(java.lang.String str) throws android.os.RemoteException;
  public java.lang.String getSettingsString(java.lang.String str) throws android.os.RemoteException;
  public void setSettingsInt(java.lang.String str, int i) throws android.os.RemoteException;
  public void setSettingsString(java.lang.String str, java.lang.String str2) throws android.os.RemoteException;
  public void addIntStatus(java.lang.String str, int i) throws android.os.RemoteException;
  public void addBooleanStatus(java.lang.String str, boolean z) throws android.os.RemoteException;
  public void addStringStatus(java.lang.String str, java.lang.String str2) throws android.os.RemoteException;
  public void saveJsonConfig(java.lang.String str, java.lang.String str2) throws android.os.RemoteException;
  public java.lang.String getJsonConfig(java.lang.String str) throws android.os.RemoteException;
}
