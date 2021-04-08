--高速决斗技能-爱即是伤
Duel.LoadScript("speed_duel_common.lua")
function c100730251.initial_effect(c)
	aux.RegisterSpeedDuelSkillCardCommon()
	aux.SpeedDuelBeforeDraw(c,c100730251.skill)
end
function c100730251.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLED)
	e3:SetValue(c100730251.abdcon)
	e3:SetCondition(c100730251.damcon)
	e3:SetOperation(c100730251.damop)
	Duel.RegisterEffect(e3,tp)
	e:Reset()
end
function c100730251.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	return tc:IsControler(tp) and tc:IsRelateToBattle() and bc:IsLocation(LOCATION_MZONE) and bc:IsType(TYPE_MONSTER) and tc:IsCode(78371393) or tc:IsCode(4779091) or tc:IsCode(31764700)
end
function c100730251.damop(e,tp,eg,ep,ev,re,r,rp) 
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	local dam=bc:GetAttack()
	if dam<0 then dam=0 end
	Duel.Damage(1-tp,dam,REASON_RULE)
end
function c100730251.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end