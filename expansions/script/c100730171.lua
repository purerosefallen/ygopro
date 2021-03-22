--高速决斗技能-沉默的决斗者
Duel.LoadScript("speed_duel_common.lua")
function c100730171.initial_effect(c)
	if not c100730171.UsedLP then
		c100730171.UsedLP={}
		c100730171.UsedLP[0]=0
		c100730171.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730171.operation,c100730171.con,aux.Stringid(100730171,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetOperation(c100730171.operation)
	c:RegisterEffect(e1)
	aux.SpeedDuelBeforeDraw(c,c100730171.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730171.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_DECK,0,1,nil,0x41)
		and Duel.GetMZoneCount(tp)>0
		and aux.DecreasedLP[tp]-c100730171.UsedLP[tp]>=1800
		and c100730171.UsedLP[tp]<3600
end

function c100730171.operation(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	c100730171.UsedLP[tp]=c100730171.UsedLP[tp]+1800
	local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
	local c=g1:GetFirst()
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730171)
		Duel.SendtoDeck(c,nil,2,REASON_RULE)
		local g=Duel.SelectMatchingCard(tp,c100730171.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
		if g:GetCount()>0 then
			local d=Duel.CreateToken(tp,25774450)
			Duel.SendtoHand(d,nil,REASON_RULE)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tc=g:GetFirst()
			local c=e:GetHandler()
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(100730171,RESET_EVENT+RESETS_STANDARD,0,1,Duel.GetTurnCount())
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetLabelObject(tc)
			e1:SetCondition(c100730171.tdcon)
			e1:SetOperation(c100730171.tdop)
			e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
			e1:SetCountLimit(1)
			Duel.RegisterEffect(e1,tp)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
			e2:SetTargetRange(LOCATION_MZONE,0)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e2:SetValue(1)
			e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
			Duel.RegisterEffect(e2,tc)
			Duel.ConfirmCards(1-tp,d)
		end
	end
end

function c100730171.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnCount()~=e:GetLabel() and Duel.GetTurnPlayer()==tp and tc:GetFlagEffectLabel(100730171)==e:GetLabel()
end
function c100730171.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,100730171)
	Duel.GetControl(tc,1-tp)
end
function c100730171.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730171.LVfilter)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c100730171.efilter)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_BASE_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100730171.LV2filter)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetValue(c100730171.val)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end

function c100730171.LV2filter(e,c)
	return c:IsSetCard(0x41) and c:IsRace(RACE_SPELLCASTER)
end

function c100730171.LVfilter(e,c)
	return c:IsSetCard(0x41) and c:IsRace(RACE_SPELLCASTER+RACE_WARRIOR)
end
function c100730171.filter(c)
	return c:IsSetCard(0x41) and c:IsLevelBelow(4)
end

function c100730171.efilter(e,te)
	return not te:GetOwner():IsSetCard(0x41)
end
function c100730171.val(e,c)
	return c:GetLevel()*1500-c:GetTextAttack()*2-c:GetTextDefense()*3
end