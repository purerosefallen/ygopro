--高速决斗技能-注定一抽
Duel.LoadScript("speed_duel_common.lua")
function c100730001.initial_effect(c)
	c100730001.DecreasedLP[0]=0
	c100730001.DecreasedLP[1]=0
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCondition(c100730001.skillcond)
	e1:SetOperation(c100730001.skill)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
	--calculate damage
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c100730001.damcon)
	e2:SetOperation(c100730001.damcal)
	e2:SetLabelObject(c)
	Duel.RegisterEffect(e2,0)
	local e3=e2:Clone()
	e3:SetCode(EVENT_PAY_LPCOST)
	e3:SetLabelObject(c)
	Duel.RegisterEffect(e3,0)
	aux.RegisterSpeedDuelSkillCardCommon()
end

c100730001.DecreasedLP={}
c100730001.NotUsed=true

function c100730001.damcon(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return ep==tp
end

function c100730001.damcal(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	c100730001.DecreasedLP[tp] = c100730001.DecreasedLP[tp] + ev
end

function c100730001.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730001,0)) then
		Duel.Hint(HINTMSG_SELECT,tp,aux.Stringid(100730001,1))
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_DECK,0,1,1,nil)
		if not g then return end
		Duel.MoveSequence(g:GetFirst(),0)
		c100730001.NotUsed = false
	end
end

function c100730001.skillcond(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and c100730001.NotUsed and c100730001.DecreasedLP[tp] >= 2000
		and ((not aux.IsTag) or math.fmod(e:GetLabel(),4)==aux.SpeedDuelSkillRegisterTurn[c])
end