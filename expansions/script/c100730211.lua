--高速决斗技能-当然是正位置！
Duel.LoadScript("speed_duel_common.lua")
function c100730211.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730211.skill)
	aux.SpeedDuelMoveCardToFieldCommon(96012004,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730211.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TOSS_COIN_NEGATE)
	e1:SetCondition(c100730211.coincon2)
	e1:SetOperation(c100730211.coinop2)
	e1:SetLabelObject(e:GetLabelObject())
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730211.coincon2(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():GetControler()==e:GetLabelObject():GetOwner()
		and re:GetHandler():IsSetCard(0x05)
end
function c100730211.coinop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,100730211)
	local res={Duel.GetCoinResult()}
	local ct=ev
	for i=1,ct do
		res[i]=1
	end
	Duel.SetCoinResult(table.unpack(res))
end
