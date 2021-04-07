--高速决斗技能-欺诈硬币
Duel.LoadScript("speed_duel_common.lua")
function c100730231.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730231.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730231.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TOSS_COIN_NEGATE)
	e1:SetCondition(c100730231.coincon2)
	e1:SetOperation(c100730231.coinop2)
	e1:SetLabelObject(e:GetLabelObject())
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730231.coincon2(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():GetControler()==e:GetLabelObject():GetOwner()
		and Duel.GetLP(tp)>=Duel.GetLP(1-tp)+1000
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=5
end
function c100730231.coinop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,100731231)
	local res={Duel.GetCoinResult()}
	local ct=ev
	for i=1,ct do
		res[i]=1
	end
	Duel.SetCoinResult(table.unpack(res))
end